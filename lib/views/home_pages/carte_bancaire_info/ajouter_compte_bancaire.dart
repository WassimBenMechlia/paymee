import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/widgets/buttons.dart';

class AjouterCompte extends StatelessWidget {
  const AjouterCompte({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: fromCssColor('#034DA3'),
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ajouter un compte bancaire',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
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
                        validator: ValidationBuilder()
                            .minLength(20)
                            .maxLength(20)
                            .build(),
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
              ),
            ),
          );
        }),
      ),
    );
  }
}
