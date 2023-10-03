// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/controllers/ApiException.dart';
import 'package:paymee/controllers/apiServices.dart';
import 'package:paymee/views/home_pages/allPages.dart';
import 'package:paymee/routes/sing_in_up_routing.dart';
import 'package:paymee/widgets/alertdialogs.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/shared_user_info.dart';
import '../../widgets/pin.dart';
import '../home_pages/unverified.dart';
import '../home_pages/verifying.dart';

class PinputPage extends StatefulWidget {
  const PinputPage({
    super.key,
  });

  @override
  State<PinputPage> createState() => _PinputPageState();
}

class _PinputPageState extends State<PinputPage> {
  Future<String?> getAuthResponse() async {
    // Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // Fetch saved data
    String? json = prefs.getString('response');

    return json;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  bool errorTxt = true;

  int numberOfTrys = 0;

  final TextEditingController _myController = TextEditingController();
  final TextEditingController _deviceId = TextEditingController();
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

  Future<void> initPlatformState() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      setState(() {
        _deviceId.text = androidDeviceInfo.id;
      });
    }
  }

  Future<String> getUserData() async {
    await initPlatformState();
    String pinJsonFormat = json.encode({
      'device_token': _deviceId.text,
      'pin': _myController.text,
    });
    print(pinJsonFormat.toString());
    return pinJsonFormat;
  }

  APIService api = APIService();

  Future<void> LoginWithPin() async {
    numberOfTrys++;

    try {
      showLoading();

      String data = await getUserData();
      print(data);
      print(await getToken());

      await api.loginUsingPin(data, await getToken());
      hideLoading();
      setState(() {
        errorTxt = true;
      });
      String? prefs = await getAuthResponse();
      AuthResponse? authData;

      if (prefs != null) {
        // Parse json to model
        authData = AuthResponse.fromJson(jsonDecode(prefs));
        print(authData.data[0].profile.status);
        print(authData.data[0].profile.idFront);
        if (authData.data[0].profile.status == "VERIFIED") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AllPages()));
        } else if (authData.data[0].profile.status == "UNVERIFIED") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => UnverifiedAcc(
                        profile: authData!.data[0].profile,
                      )));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const VerifyingAcc()));
        }
      }
    } on ApiException catch (e) {
      setState(() {
        errorTxt = false;
      });
      print(e.message);
      hideLoading();
      if (numberOfTrys == 3) {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('response');
        prefs.remove('token');
        Future showErrorDialog() async {
          return showDialog(
              context: context,
              builder: (context) {
                return const ErrorMessage(
                    error:
                        "Erreur de connextion , veuillez de reconnecter avec le numero de telephone ");
              });
        }

        await showErrorDialog();

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SignInUp()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: const TextStyle(
        fontSize: 15,
      ),
      decoration: BoxDecoration(
          color: const Color(0xFFE6E9EF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 0.7,
            color: errorTxt == false ? Colors.red : Colors.transparent,
          )),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
          color: errorTxt == false ? Colors.red : fromCssColor('#034DA3')),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Vérifier votre compte',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Veuillez entrer le code pin que vous avez choisi',
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      autofocus: true,
                      submittedPinTheme: submittedPinTheme,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      keyboardType: TextInputType.none,
                      controller: _myController,
                      length: 6,
                    ),
                  ],
                ),
                Visibility(
                  visible: !errorTxt,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                        child: Text(
                      'code incorrect!',
                      style: TextStyle(color: Colors.red, fontSize: 17),
                    )),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Divider(
                    thickness: 2,
                    color: fromCssColor('#034DA3'),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                NumPad(
                  controller: _myController,
                  delete: () {
                    _myController.text.isNotEmpty
                        ? _myController.text = _myController.text
                            .substring(0, _myController.text.length - 1)
                        : null;
                  },
                  // do something with the input numbers
                  onSubmit: () {
                    if (canSubmit && _myController.text.length == 6) {
                      LoginWithPin();
                    }
                  },
                ),
                const SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
