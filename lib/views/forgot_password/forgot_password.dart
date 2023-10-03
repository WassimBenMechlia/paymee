import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/views/verify_username/verif_username.dart';

import '../../routes/sing_in_up_routing.dart';
import '../../widgets/buttons.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: fromCssColor('#034DA3'),
              iconSize: 30,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignInUp()));
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Ecriver votre numéro pour changer le mot de passe ',
                  style: TextStyle(fontSize: 20, color: Colors.grey[700])),
              const SizedBox(
                height: 20,
              ),
              Text('Téléphone',
                  style: TextStyle(fontSize: 20, color: Colors.grey[700])),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: formkey,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      hintText: 'Entrez voter numero',
                      border: OutlineInputBorder()),
                  validator: ValidationBuilder()
                      .phone()
                      .minLength(8)
                      .maxLength(8)
                      .build(),
                ),
              ),
              const Spacer(),
              MyButton(
                  btnText: 'Continuer',
                  btnColor: fromCssColor('#034DA3'),
                  txtColor: Colors.white,
                  onTap: () {
                    if (!formkey.currentState!.validate()) {
                      formkey.currentState?.save();
                      return;
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Verif(
                                    prevPage: '/resetPassword',
                                  )));
                    }
                  },
                  borderColor: Colors.transparent),
            ]),
          )),
    );
  }
}
