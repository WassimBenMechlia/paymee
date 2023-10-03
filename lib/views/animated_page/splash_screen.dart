import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:paymee/views/custom_pinput/random_order_pinput.dart';
import 'package:paymee/views/welcome_page.dart';

import '../../Models/shared_user_info.dart';

class SplashScreen extends StatefulWidget {
  final AuthResponse? authData;

  const SplashScreen({super.key, required this.authData});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void printFileStructure(dynamic data, {String path = ''}) {
    if (data['name'] != null) {
      path += '/' + data['name'];
    }

    if (data['children'] != null) {
      for (var child in data['children']) {
        printFileStructure(child, path: path);
      }
    } else {
      Image image = Image.asset(path.substring(1));

      precacheImage(image.image, context);
      print(path.substring(1));
    }
  }

  Future<void> getFileData() async {
    final String response = await rootBundle.loadString('assets/data.json');

    final data = await jsonDecode(response);
    printFileStructure(data);
  }

  @override
  void initState() {
    super.initState();
    getFileData();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 1300),
              child: widget.authData?.data[0].token == null
                  ? const Welcome()
                  : const PinputPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/paymeeback2.png'),
                  fit: BoxFit.cover)),
          child: Lottie.asset(
            'assets/loading/loadingscreen.json',
            repeat: false,
            frameRate: FrameRate(1500),
          ),
        ),
      ),
    );
  }
}
