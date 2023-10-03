import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

class DottedBorderImagePicker extends StatelessWidget {
  const DottedBorderImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      dashPattern: const [7, 3],
      strokeWidth: 1.5,
      child: SizedBox(
        height: 100,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Icon(
                Icons.camera_alt,
                color: fromCssColor('#034DA3'),
                size: 24,
                semanticLabel: 'Take photo',
              ),
              Text(
                'Aucune fichier télécharger',
                style: TextStyle(fontSize: 16, color: fromCssColor('#034DA3')),
              ),
              Text('Appuyer ici pour télécharger une image',
                  style:
                      TextStyle(fontSize: 13, color: fromCssColor('#034DA3')))
            ],
          ),
        ),
      ),
    );
  }
}
