import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/widgets/account.dart';

import '../routes/sing_in_up_routing.dart';

class SelectAccount extends StatelessWidget {
  const SelectAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Continuer en tant que",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "rtyu ghjk uio ghjk bn, ghj yuiop dzduyzgf ffbryfb bdsubzed ",
                  style:
                      TextStyle(color: fromCssColor('#697386'), fontSize: 17),
                ),
                const SizedBox(
                  height: 30,
                ),
                Account(
                  onTap: () {},
                  isparticulier: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Account(
                  isparticulier: false,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInUp(),
                        ));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
