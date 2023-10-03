import 'package:flutter/material.dart';
import 'package:paymee/views/register_pages/phone_page.dart';
import 'package:paymee/views/register_pages/sms_code_validation_page.dart';

import '../views/register_pages/info_personelles_societe.dart';

class PhoneVal extends StatefulWidget {
  const PhoneVal({super.key});

  @override
  State<PhoneVal> createState() => _PhoneValState();
}

class _PhoneValState extends State<PhoneVal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const PhonePage(),
        '/SmsCodeValidation': (context) => const SmsCodeValidation(),
        '/AllInfo': (context) => const InfoPersonnels(),
      },
    );
  }
}
