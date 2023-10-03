import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/widgets/buttons.dart';

class EditCompte extends StatefulWidget {
  const EditCompte({super.key});

  @override
  State<EditCompte> createState() => _EditCompteState();
}

class _EditCompteState extends State<EditCompte> {
  @override
  Widget build(BuildContext context) {
    void close() {
      Navigator.pop(context);
    }

    return MaterialApp();
  }
}






/* LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                        color: Colors.white,
                      ),
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
                                      close();
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
                ),
              ),
            ),
          );
        }), */