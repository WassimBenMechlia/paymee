import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../controllers/ApiException.dart';
import '../../widgets/alertdialogs.dart';
import '../../widgets/buttons.dart';
import '../../controllers/apiServices.dart';

class SmsCodeValidation extends StatefulWidget {
  const SmsCodeValidation({
    super.key,
  });

  @override
  State<SmsCodeValidation> createState() => _SmsCodeValidationState();
}

class _SmsCodeValidationState extends State<SmsCodeValidation> {
  final hashController = TextEditingController();
  final codeController = TextEditingController();
  final usernamController = TextEditingController();
  final focusNode = FocusNode();
  APIService api = APIService();
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

  Future<void> getConfirmationCode() async {
    try {
      String sms = jsonEncode({'username': usernamController.text});
      showLoading();

      hashController.text = await api.requestCodeForRegister(sms);
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

  void ferifySMSCode() async {
    String data = json.encode({
      'code': codeController.text,
      'hash': hashController.text,
    });
    try {
      showLoading();
      String res = await api.verifyCodeForRegister(data);

      print(res);
      print(data);
      hideLoading();

      setState(() {
        expire = true;
        errorTxt = true;
      });
      Navigator.pushNamed(context, '/AllInfo', arguments: {
        'username': usernamController.text,
        'hash': hashController.text,
        'pin': codeController.text,
      });
    } on Exception {
      hideLoading();

      setState(() {
        expire = false;
        errorTxt = false;
        inputcounter++;
      });
    }
  }

  late Timer timer;
  @override
  void dispose() {
    codeController.dispose();
    focusNode.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    startTimer(120);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
      hashController.text = args['hash'].toString();
      usernamController.text = args['username'].toString();
      // Use args
    }
  }

  int inputcounter = 0;
  bool errorTxt = true;
  int attemptCount = 0;
  bool expire = true;
  String second = '0';
  int nbressay = 0;
  String minute = '0';

  void startTimer(int start) {
    const oneSec = Duration(seconds: 1);

    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0 || errorTxt == false) {
          timer.cancel();
          nbressay++;
          setState(() {
            expire = false;
          });
        } else {
          start--;
          setState(() {
            minute = (start ~/ 60).toString().padLeft(2, '0');
            second = (start % 60).toString().padLeft(2, '0');
          });
        }
      },
    );
  }

  void resetTimer() {
    if (nbressay == 1) {
      setState(() {
        errorTxt = true;
        expire = true;
        startTimer(20);
      });
    } else if (nbressay == 2) {
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
          const Text("Vous n'avez pas reçu de code ? "),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: errorTxt == false,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: const Text(
                        'Changer un autre numéro',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Text(' ou '),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  resetTimer();
                  getConfirmationCode();
                },
                child: const Text(
                  'Cliquez pour renvoyer',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
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
          shadowColor: null,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: fromCssColor('#034DA3'),
            iconSize: 30,
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 15),
              child: Text(
                "Etape 2/8",
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
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vérifier votre compte',
                    style: GoogleFonts.inter(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Veuillez entrer 4 numéros que nous avons envoyés à votre numéro de téléphone pour vérifier votre compte',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                    ),
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
              controller: codeController,
              autofocus: true,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
            ),
            const SizedBox(
              height: 15,
            ),
            Visibility(
              visible: expire == true,
              child: Text(minute != '00'
                  ? 'Expire dans $minute m : $second s'
                  : 'Expire dans $second seconds'),
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
            MyButton(
                btnText: 'Vérifier',
                btnColor: fromCssColor('#034DA3'),
                txtColor: Colors.white,
                onTap: () async {
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
                  canSubmit ? ferifySMSCode() : null;
                },
                borderColor: Colors.transparent)
          ]),
        ),
      ),
    );
  }
}
