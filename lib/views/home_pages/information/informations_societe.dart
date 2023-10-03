import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:from_css_color/from_css_color.dart';

import '../../../widgets/buttons.dart';

class InformationSociete extends StatefulWidget {
  const InformationSociete({super.key});

  @override
  State<InformationSociete> createState() => _InformationSocieteState();
}

class _InformationSocieteState extends State<InformationSociete> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 3.5;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/profilebackground.png'),
                          fit: BoxFit.fill),
                    ),
                    child: SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 150,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          child: Container(
                            height: 170,
                            width: 170,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/plogo.png'),
                              ),
                            ),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: Image.asset(
                                          'assets/images/addphoto.png')),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Forme juridique',
                        style: TextStyle(
                            fontSize: 17, color: fromCssColor('#697386'))),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        validator: ValidationBuilder().build()),
                    const SizedBox(
                      height: 15,
                    ),
                    Text('Raison sociale',
                        style: TextStyle(
                            fontSize: 17, color: fromCssColor('#697386'))),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        validator: ValidationBuilder().build()),
                    const SizedBox(
                      height: 15,
                    ),
                    Text('Matricule fiscale',
                        style: TextStyle(
                            fontSize: 17, color: fromCssColor('#697386'))),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        validator: ValidationBuilder().build()),
                    const SizedBox(
                      height: 15,
                    ),
                    Text('Adresse',
                        style: TextStyle(
                            fontSize: 17, color: fromCssColor('#697386'))),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        validator: ValidationBuilder().build()),
                    const SizedBox(
                      height: 15,
                    ),
                    Text('Site web',
                        style: TextStyle(
                            fontSize: 17, color: fromCssColor('#697386'))),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        validator: ValidationBuilder().build()),
                    const SizedBox(
                      height: 15,
                    ),
                    Text('Activités',
                        style: TextStyle(
                            fontSize: 17, color: fromCssColor('#697386'))),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        validator: ValidationBuilder().build()),
                    const SizedBox(
                      height: 15,
                    ),
                    MyButton(
                        btnText: 'Enregistrer',
                        btnColor: fromCssColor('#034DA3'),
                        txtColor: Colors.white,
                        onTap: () {},
                        borderColor: Colors.transparent)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
