// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paymee/views/home_pages/verifying.dart';
import 'package:paymee/widgets/buttons.dart';
import 'package:paymee/views/home_pages/allPages.dart';
import 'package:paymee/views/reset_password/reset_password.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../Models/shared_user_info.dart';
import '../../controllers/ApiException.dart';
import '../../controllers/apiServices.dart';
import '../../routes/sing_in_up_routing.dart';
import '../../widgets/alertdialogs.dart';
import '../home_pages/unverified.dart';

class Verif extends StatefulWidget {
  final String prevPage;

  const Verif({super.key, required this.prevPage});

  @override
  State<Verif> createState() => _VerifState();
}

class _VerifState extends State<Verif> {
  final focusNode = FocusNode();
  final usernamController = TextEditingController();
  final hashController = TextEditingController();
  late TextEditingController codeController = TextEditingController();
  final passwordController = TextEditingController();

  late Timer timer;
  @override
  void dispose() {
    timer.cancel();
    codeController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
      hashController.text = args['hash'].toString();
      usernamController.text = args['username'].toString();
      passwordController.text = args['password'].toString();
      print(passwordController.text);

      // Use args
    }
  }

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

  Future<String?> getUserData() async {
    // Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // Fetch saved data
    String? json = prefs.getString('response');

    return json;
  }

  APIService api = APIService();

  Future<void> resendPassword() async {
    try {
      String json = jsonEncode({
        'username': usernamController.text,
        'password': passwordController.text,
      });
      showLoading();
      hashController.text = await api.requestCodeForLogin(json);
      hideLoading();
    } on ApiException catch (e) {
      hideLoading();
      showDialog(
          context: context,
          builder: (context) => ErrorMessage(
                error: e.message,
              ));
    }
  }

  Future<void> LoginWithUsername() async {
    try {
      String data = json.encode({
        'code': codeController.text,
        'hash': hashController.text,
        'username': usernamController.text,
      });
      print(data);
      showLoading();

      await api.confirmCodeForLogin(data);
      setState(() {
        expire = true;
        errorTxt = true;
        inputcounter++;
      });
      hideLoading();
      if (widget.prevPage == '/resetPassword') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ResetPassword()));
      }

      String? prefs = await getUserData();
      AuthResponse? authData;

      if (prefs != null) {
        // Parse json to model
        authData = AuthResponse.fromJson(jsonDecode(prefs));
        print(authData.toString());
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
      hideLoading();
      setState(() {
        expire = false;
        errorTxt = false;
      });
      print(e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    SmsAutoFill().listenForCode();

    startTimer(120);
  }

  int inputcounter = 0;
  bool errorTxt = true;
  int attemptCount = 0;
  bool expire = true;
  String s = '0';
  int NbrEssay = 0;
  String m = '0';

  void startTimer(int start) {
    const oneSec = Duration(seconds: 1);

    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0 || errorTxt == false) {
          timer.cancel();
          NbrEssay++;
          setState(() {
            expire = false;
          });
        } else {
          start--;
          setState(() {
            m = (start ~/ 60).toString().padLeft(2, '0');
            s = (start % 60).toString().padLeft(2, '0');
          });
        }
      },
    );
  }

  void resetTimer() {
    if (NbrEssay == 1) {
      setState(() {
        errorTxt = true;
        expire = true;
        startTimer(20);
      });
    } else if (NbrEssay == 2) {
      setState(() {
        errorTxt = true;
        expire = true;
        startTimer(10);
      });
    }
    Null;
  }

  Widget? afterTimeOut() {
    if (errorTxt == false || expire == false) {
      return Column(
        children: [
          Text(
            "Vous n'avez pas reçu de code ? ",
            style: TextStyle(color: Colors.grey[600]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: errorTxt == false,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.prevPage == '/') {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInUp()));
                        } else {
                          Navigator.pushNamed(context, '/resetPassword');
                        }
                      },
                      child: Text(
                        'Changer un autre numéro',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      ' ou ',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await resendPassword();
                  resetTimer();
                },
                child: Text(
                  'Cliquez pour renvoyer',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return null;
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
            width: 1,
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
        appBar: AppBar(
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
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vérifier votre compte',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Veuillez entrer 4 numéros que nous avons envoyés à votre numéro de téléphone pour vérifier votre compte',
                    style:
                        TextStyle(color: fromCssColor('#697386'), fontSize: 17),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Pinput(
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              autofocus: true,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              controller: codeController,
            ),
            const SizedBox(
              height: 15,
            ),
            Visibility(
              visible: expire == true,
              child: Text(
                  m != '00' ? 'Expire dans $m m : $s s' : 'Expire dans $s s'),
            ),
            Visibility(
                visible: errorTxt == false,
                child: const Text(
                  'Code incorrecte! Veuillez verifier le code envoyé',
                  style: TextStyle(color: Colors.red),
                )),
            const SizedBox(
              height: 30,
            ),
            Container(child: afterTimeOut()),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyButton(
                  btnText: 'Vérifier',
                  btnColor: fromCssColor('#034DA3'),
                  txtColor: Colors.white,
                  onTap: () {
                    if (inputcounter == 10) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text('too many requests'),
                                const SizedBox(height: 15),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    canSubmit ? LoginWithUsername() : null;
                  },
                  borderColor: Colors.transparent),
            )
          ]),
        ),
      ),
    );
  }
}
