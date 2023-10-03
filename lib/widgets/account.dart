// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

class Account extends StatefulWidget {
  final bool isparticulier;

  final void Function()? onTap;
  const Account({
    super.key,
    required this.onTap,
    required this.isparticulier,
  });

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late Text Title;
  late Color backColor;
  late Color titleColor;
  late Color bodyColor;
  late Color btnTextColor;
  late Color btnColor;
  late String img;
  late Text bodyText;
  void setProperties() {
    if (widget.isparticulier) {
      Title = const Text(
        'Particulier',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      );
      backColor = fromCssColor('#F5F5F5');

      btnTextColor = Colors.white;
      btnColor = fromCssColor('#034DA3');
      img = "assets/images/particulier.png";
      bodyText = Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        style: TextStyle(
          fontSize: 18,
          color: fromCssColor('#6D7885'),
        ),
      );
    } else {
      Title = const Text(
        'Business',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      );
      backColor = fromCssColor('#034DA3');

      btnTextColor = Colors.black;
      btnColor = Colors.white;
      img = "assets/images/business.png";
      bodyText = const Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        style: TextStyle(fontSize: 18, color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    setProperties();
    return Card(
      elevation: 0,
      color: backColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          ListTile(
              trailing: Image.asset(
                img,
              ),
              title: Title,
              subtitle: bodyText),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: btnTextColor,
                        backgroundColor: btnColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: widget.onTap,
                    child: const Text('Continuer')),
              )
            ],
          )
        ],
      ),
    );
  }
}





/* 
 Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: titleColor)),
                  Text(
                    Body,
                    style: TextStyle(color: bodyColor),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: btnTextColor,
                          backgroundColor: btnColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: onTap,
                      child: const Text('Continuer'))
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset(img),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ); */