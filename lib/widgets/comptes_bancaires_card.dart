import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:page_transition/page_transition.dart';

import '../views/home_pages/carte_bancaire_info/edit_compte_bancaire.dart';
import 'buttons.dart';

class Comptes extends StatefulWidget {
  const Comptes({
    super.key,
  });

  @override
  State<Comptes> createState() => _ComptesState();
}

class _ComptesState extends State<Comptes> {
  editAcc(BuildContext context) {
    return showModalBottomSheet<dynamic>(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close_rounded))
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Modifier votre compte 1',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Nom',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Entrez votre nom',
                    border: OutlineInputBorder(),
                  ),
                  validator: ValidationBuilder().build(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Banque',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'Entrez votre banque',
                      border: OutlineInputBorder()),
                  validator: ValidationBuilder().build(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "RIB",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Entrez votre RIB',
                      border: OutlineInputBorder()),
                  validator:
                      ValidationBuilder().minLength(20).maxLength(20).build(),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Spacer(),
                MyButton(
                    btnText: 'Enregistrer',
                    btnColor: fromCssColor('#034DA3'),
                    txtColor: Colors.white,
                    onTap: () {},
                    borderColor: Colors.white)
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Color? titleColors = Colors.grey[700];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: height / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Détails du compte 1',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          editAcc(context);
                          /*  Navigator.push(
                            context,
                            PageTransition(
                                child: editAcc() /*  const EditCompte() */,
                                type: PageTransitionType.bottomToTop,
                                duration: const Duration(milliseconds: 600)),
                          ); */
                          /*    MaterialPageRoute(
                                builder: (context) => EditCompte(),
                              )); */
                        },
                        child: SvgPicture.asset(
                          'assets/images/edit.svg',
                          semanticsLabel: 'My SVG Image',
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              /* title: const Text("Title"), */
                              content: const Text(
                                  "êtes-vous sûr de vouloir supprimer ce compte ?"),
                              actions: [
                                // Close the dialog
                                CupertinoButton(
                                    child: const Text('confirmer'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                                CupertinoButton(
                                    child: const Text('annuler'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                              ],
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/images/del.svg',
                          semanticsLabel: 'My SVG Image',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Nom',
                style: TextStyle(color: titleColors),
              ),
              const Text('Paymee',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Banque',
                style: TextStyle(color: titleColors),
              ),
              const Text(
                'AlBaraka',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'RIB',
                style: TextStyle(color: titleColors),
              ),
              const Text('2563 9035 9116 3002 7836 3014 600',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
