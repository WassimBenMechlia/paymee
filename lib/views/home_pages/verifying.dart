import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../welcome_page.dart';

class VerifyingAcc extends StatefulWidget {
  const VerifyingAcc({super.key});

  @override
  State<VerifyingAcc> createState() => _VerifyingAccState();
}

class _VerifyingAccState extends State<VerifyingAcc> {
  Future<void> logout() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        /* title: const Text("Title"), */
        content: const Text("êtes-vous sûr de vouloir quitter"),
        actions: [
          // Close the dialog
          CupertinoButton(
              child: const Text('confirmer'),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                prefs.remove('response');
                Navigator.of(context).pop();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => const Welcome())));
              }),
          CupertinoButton(
              child: const Text('annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/paymeeback2.png'),
                  fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  await logout();
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height / 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 150,
                    width: 150,
                    child: LottieBuilder.asset(
                      'assets/loading/check3sec.json',
                      repeat: false,
                      frameRate: FrameRate(1000),
                    )

                    /* Image.asset('assets/images/verified.png') */
                    ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(200, 30),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(children: [
                  Text(
                    'Compte en cours de verificacion',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Votre compte est actuellement en cours de vérification par nos administrateurs.',
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    'Ce processus prend généralement entre 12 et 24 heures.Vous serez notifié par email dès que la vérification sera terminée. Merci pour votre patience.',
                    style: TextStyle(fontSize: 17),
                  )
                ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
