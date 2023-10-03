import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/widgets/buttons.dart';

class AjoutCarte extends StatelessWidget {
  const AjoutCarte({super.key});

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
          title: const Text(
            'Ajouter une carte',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Numero de la carte',
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
                    hintText: 'Entrez votre numero de carte',
                    border: OutlineInputBorder()),
                validator:
                    ValidationBuilder().minLength(16).maxLength(16).build(),
              ),
              const SizedBox(
                height: 20,
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
                    hintText: 'Entrez votre nom', border: OutlineInputBorder()),
                validator: ValidationBuilder().build(),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date d'expiration",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.datetime,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'mm/aa', border: OutlineInputBorder()),
                          validator: ValidationBuilder().build(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'CVV',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                          validator: ValidationBuilder().minLength(3).build(),
                        ),
                      ],
                    ),
                  )
                ],
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
    );
  }
}
