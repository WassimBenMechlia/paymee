import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/widgets/buttons.dart';
import 'package:paymee/views/account_type.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 7;
    print(height);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/paymeeback2.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height),
                child: SvgPicture.asset('assets/images/Frame.svg'),
              ),
              Text(
                'Bienvenue',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: fromCssColor('#AFD5FD')),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Paymee',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Le paiement simplifié',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MyButton(
                      borderColor: Colors.transparent,
                      btnText: 'Commencer',
                      btnColor: Colors.white,
                      txtColor: fromCssColor('#034DA3'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SelectAccount(),
                            ));
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 1.5),
                child: SvgPicture.asset('assets/images/Group.svg'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
