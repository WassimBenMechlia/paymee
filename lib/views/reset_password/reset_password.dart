import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:from_css_color/from_css_color.dart';

import '../../routes/sing_in_up_routing.dart';
import '../../widgets/buttons.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
              Navigator.of(context).pop();
            },
          ),
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return SafeArea(
              child: SingleChildScrollView(
                  child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formkey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Créer un autre mot de passe '),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Mot de passe',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                              hintText: 'Entrez voter mot de passe',
                              border: OutlineInputBorder()),
                          validator: ValidationBuilder().minLength(8).build(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Confirmer le mot de passe',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: confirmPasswordController,
                          autovalidateMode: AutovalidateMode.always,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Entrez voter mot de passe',
                              border: OutlineInputBorder()),
                          validator: ValidationBuilder().minLength(8).build(),
                        ),
                        const Spacer(),
                        MyButton(
                            btnText: 'Confirmer',
                            btnColor: fromCssColor('#034DA3'),
                            txtColor: Colors.white,
                            onTap: () {
                              if (!formkey.currentState!.validate()) {
                                formkey.currentState?.save();
                                return;
                              } else if (passwordController.text !=
                                  confirmPasswordController.text) {
                                return;
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInUp()));
                              }
                            },
                            borderColor: Colors.transparent),
                      ]),
                ),
              ),
            ),
          )));
        }),
      ),
    );
  }
}
