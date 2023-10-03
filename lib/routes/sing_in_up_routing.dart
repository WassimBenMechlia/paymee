import 'package:flutter/material.dart';

import '../views/forgot_password/forgot_password.dart';
import '../views/signup_in.dart';
import '../views/verify_username/verif_username.dart';

class SignInUp extends StatelessWidget {
  const SignInUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Signin(),
        '/SigninPhone': (context) => const Verif(
              prevPage: '/',
            ),
        '/resetPassword': (context) => const ForgotPassword(),
      },
    );
  }
}
