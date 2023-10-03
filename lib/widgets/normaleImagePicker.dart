import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

class NormaleImagePicker extends StatelessWidget {
  const NormaleImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: fromCssColor('#034DA3')),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              color: fromCssColor('#034DA3'),
              size: 30,
            ),
            Text(
              'Fichier enregistrer',
              style: TextStyle(
                color: fromCssColor('#034DA3'),
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
