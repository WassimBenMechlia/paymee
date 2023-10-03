import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/widgets/buttons.dart';

import '../../widgets/comptes_bancaires_card.dart';
import 'carte_bancaire_info/ajouter_compte_bancaire.dart';

class Comptesbancaires extends StatefulWidget {
  const Comptesbancaires({super.key});

  @override
  State<Comptesbancaires> createState() => _ComptesbancairesState();
}

class _ComptesbancairesState extends State<Comptesbancaires> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => const Comptes(),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        MyButton(
            btnText: 'Ajouter un compte bancaire',
            btnColor: fromCssColor('#034DA3'),
            txtColor: Colors.white,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AjouterCompte()));
            },
            borderColor: Colors.transparent)
      ],
    );
  }
}
