import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/widgets/buttons.dart';

import '../../controllers/ApiException.dart';
import '../../controllers/apiServices.dart';
import '../../routes/sing_in_up_routing.dart';
import '../../widgets/alertdialogs.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({
    super.key,
  });

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final hashController = TextEditingController();
  final usernamController = TextEditingController();

  APIService api = APIService();

  final formKey = GlobalKey<FormState>();

  bool canSubmit = true;

  void showLoading() {
    setState(() {
      canSubmit = !canSubmit;
    });
    loadingOverlay = OverlayEntry(
      builder: (context) => const Center(
        child: LoadingCircle(),
      ),
    );

    Overlay.of(context).insert(loadingOverlay!);
  }

  OverlayEntry? loadingOverlay;

  void hideLoading() {
    setState(() {
      canSubmit = !canSubmit;
    });
    loadingOverlay!.remove();
    loadingOverlay = null;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> getConfirmationCode() async {
      try {
        String sms = jsonEncode({'username': usernamController.text});
        showLoading();

        hashController.text = await api.requestCodeForRegister(sms);
        print(hashController.text);
        hideLoading();
        Navigator.pushNamed(context, '/SmsCodeValidation', arguments: {
          'hash': hashController.text,
          'username': usernamController.text
        });
      } on ApiException catch (e) {
        hideLoading();
        showDialog(
            context: context,
            builder: (context) => ErrorMessage(
                  error: e.message,
                ));
      }
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            shadowColor: null,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: fromCssColor('#034DA3'),
              iconSize: 30,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const SignInUp()));
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 15),
                child: Text(
                  "Etape 1/8",
                  style: TextStyle(
                    fontSize: 20,
                    color: fromCssColor('#034DA3'),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Numéro de téléphone',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Entrez votre numéro de téléphone pour activer la vérification en 2 étapes',
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text('Téléphone',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                      controller: usernamController,
                      maxLength: 8,
                      keyboardType: TextInputType.number,
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          hintText: 'Entrez voter numero',
                          border: OutlineInputBorder()),
                      validator: ValidationBuilder()
                          .phone()
                          .minLength(8)
                          .maxLength(8)
                          .build()),
                ),
                const Spacer(),
                MyButton(
                    btnText: 'Continuer',
                    btnColor: fromCssColor('#034DA3'),
                    txtColor: Colors.white,
                    onTap: () async {
                      if (!formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        return;
                      } else {
                        canSubmit ? getConfirmationCode() : null;
                      }
                    },
                    borderColor: Colors.transparent)
              ],
            ),
          ),
        ));
  }
}
