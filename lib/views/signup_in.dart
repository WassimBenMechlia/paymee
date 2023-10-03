import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:paymee/widgets/buttons.dart';
import 'package:paymee/views/account_type.dart';
import 'package:paymee/routes/username_validating_routing.dart';
import 'package:paymee/widgets/theme.dart';

import '../controllers/ApiException.dart';
import '../controllers/apiServices.dart';
import '../widgets/alertdialogs.dart';
import 'forgot_password/forgot_password.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool clickable = true;

  final usernamController = TextEditingController();
  final passwordController = TextEditingController();
  final hashController = TextEditingController();

  void showLoading() {
    clickable = !clickable;

    loadingOverlay = OverlayEntry(
      builder: (context) => const Center(
        child: LoadingCircle(),
      ),
    );
    Overlay.of(context).insert(loadingOverlay!);
  }

  OverlayEntry? loadingOverlay;

  void hideLoading() {
    clickable = !clickable;

    loadingOverlay!.remove();
    loadingOverlay = null;
  }

  APIService api = APIService();

  Future<void> LoginWithUsername() async {
    try {
      String json = jsonEncode({
        'username': usernamController.text,
        'password': passwordController.text,
      });
      showLoading();

      hashController.text = await api.requestCodeForLogin(json);
      hideLoading();
      Navigator.pushNamed(context, '/SigninPhone', arguments: {
        'hash': hashController.text,
        'username': usernamController.text,
        'password': passwordController.text,
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

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: fromCssColor('#034DA3'),
              iconSize: 30,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectAccount(),
                    ));
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Bonjour,',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Content de vous revoir',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Numéro de téléphone',
                            style: TextStyle(
                                color: fromCssColor('#697386'), fontSize: 17),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(8)
                          ],
                          
                          controller: usernamController,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                              hintText: 'Entrez voter numero',
                              border: OutlineInputBorder()),
                          validator: ValidationBuilder().minLength(8).build()),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Mot de passe',
                            style: TextStyle(
                                color: fromCssColor('#697386'), fontSize: 17),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        validator: ValidationBuilder().minLength(8).build(),
                        controller: passwordController,
                        decoration: const InputDecoration(
                            hintText: 'Entrez voter mot de passe',
                            border: OutlineInputBorder()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              clickable
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const ForgotPassword())))
                                  : null;
                            },
                            child: Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                  fontSize: 18, color: fromCssColor('#125FB9')),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                MyButton(
                  btnText: 'Se connecter',
                  btnColor: fromCssColor('#034DA3'),
                  txtColor: Colors.white,
                  borderColor: Colors.transparent,
                  onTap: () {
                    if (!formKey.currentState!.validate()) {
                      formKey.currentState?.save();
                      return;
                    } else {
                      clickable ? LoginWithUsername() : null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyButton(
                  btnColor: Colors.white,
                  btnText: 'Créer un compte',
                  txtColor: fromCssColor('#034DA3'),
                  borderColor: Colors.grey,
                  onTap: () {
                    clickable
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PhoneVal(),
                            ))
                        : null;
                  },
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
    );
  }
}
