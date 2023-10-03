import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/test.dart';
import 'package:paymee/views/animated_page/splash_screen.dart';
import 'package:paymee/views/home_pages/allPages.dart';
import 'package:paymee/widgets/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/shared_user_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp(
    authData: null,
  ));

  final prefs = await SharedPreferences.getInstance();
  String? json = prefs.getString('response');

  AuthResponse? authData;

  if (json != null) {
    // Parse json to model
    authData = AuthResponse.fromJson(jsonDecode(json));
    print(authData.data[0].token);
    prefs.setString('token', authData.data[0].token);
  }

  runApp(MyApp(authData: authData));
}

class MyApp extends StatelessWidget {
  final AuthResponse? authData;
  const MyApp({super.key, required this.authData});

  @override
  Widget build(BuildContext context) {
    Image image = Image.asset('assets/images/paymeeback2.png');

    precacheImage(image.image, context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: /* AllPages(), */
          SplashScreen(
        authData: authData,
      ),
    );
  }
}
