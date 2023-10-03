// ignore_for_file: prefer_interpolation_to_compose_strings, unused_field, use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/Models/user_model.dart';
import 'package:paymee/controllers/ApiException.dart';
import 'package:paymee/views/custom_pinput/random_order_pinput.dart';
import '../../widgets/alertdialogs.dart';
import '../../widgets/classes.dart';
import '../../widgets/buttons.dart';
import '../../controllers/apiServices.dart';
import '../../widgets/image.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final usernamController = TextEditingController();
  final prenomController = TextEditingController();
  final nomController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final pinController = TextEditingController();
  final codeController = TextEditingController();
  final raisonSocialController = TextEditingController();
  final formeJuridiqueController = TextEditingController();
  final matriculeFiscaleController = TextEditingController();
  final adresseController = TextEditingController();
  final siteWebController = TextEditingController();
  final activitesController = TextEditingController();
  final image1Controller = TextEditingController();
  final image2Controller = TextEditingController();
  final image3Controller = TextEditingController();
  final image4Controller = TextEditingController();
  final hashController = TextEditingController();
  final deviceId = TextEditingController();
  bool canSubmit = true;
  void showLoading() {
    setState(() {
      canSubmit = !canSubmit;
    });
    loadingOverlay = OverlayEntry(
      builder: (context) => const Center(
        child: LoadingCircle(),
      ),
    );

    Overlay.of(context).insert(loadingOverlay!);
  }

  OverlayEntry? loadingOverlay;

  void hideLoading() {
    setState(() {
      canSubmit = !canSubmit;
    });
    loadingOverlay!.remove();
    loadingOverlay = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (ModalRoute.of(context)!.settings.arguments != null) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
      hashController.text = args['hash'].toString();
      codeController.text = args['pin'].toString();
      usernamController.text = args['username'].toString();
      // Use args
    }
  }

  var step = MyStepper();
  void reg() async {
    final user = UserModel(
      numero: usernamController.text.trim(),
      activites: activitesController.text.trim(),
      adresse: adresseController.text.trim(),
      siteWeb: siteWebController.text.trim(),
      email: emailController.text.trim(),
      formeJuridique: formeJuridiqueController.text.trim(),
      matriculeFiscale: matriculeFiscaleController.text.trim(),
      nom: nomController.text.trim(),
      password: passwordController.text.trim(),
      pin: pinController.text.trim(),
      prenom: prenomController.text.trim(),
      raisonSocial: raisonSocialController.text.trim(),
      image1: image1Controller.text.trim(),
      image2: image2Controller.text.trim(),
      image3: image3Controller.text.trim(),
      image4: image4Controller.text.trim(),
      deviceId: deviceId.text.trim(),
      hash: hashController.text.trim(),
      code: codeController.text.trim(),
    );
    print(user.pin);
    FormData formdata = await user.Register();
    print(formdata.fields);
    print(formdata.files);
  }

  bool imgCheck() {
    if (image1Controller.text.trim().toString() != '' &&
        image2Controller.text.trim().toString() != '' &&
        image3Controller.text.trim().toString() != '' &&
        image4Controller.text.trim().toString() != '') {
      return true;
    } else {
      return false;
    }
  }

  Future<void> sheckmail() async {
    showLoading();

    try {
      await api.sheckMail(json.encode({
        'email': emailController.text,
      }));
      hideLoading();
      step.incriment();
      changeVisibility(this, step.currentPage);
    } on ApiException catch (e) {
      hideLoading();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => ErrorMessage(
                error: e.message,
              ));
    }
  }

  APIService api = APIService();

  bool thirdPage = true;
  bool fourthPage = false;
  bool fifthPage = false;
  bool sixthPage = false;
  bool seventhPage = false;
  bool eighthPage = false;

  Widget? checkBox() {
    if (checkColor) {
      return GestureDetector(
        onTap: () => setState(() {
          check = !check;
        }),
        child: Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: fromCssColor('#034DA3'),
              )),
          child: check
              ? Icon(
                  Icons.check,
                  color: fromCssColor('#034DA3'),
                  size: 15,
                )
              : null,
        ),
      );
    }
    return GestureDetector(
      onTap: () => setState(() {
        check = !check;
      }),
      child: Container(
        height: 18,
        width: 18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: Colors.red,
            )),
        child: check
            ? Icon(
                Icons.check,
                color: fromCssColor('#034DA3'),
                size: 15,
              )
            : null,
      ),
    );
  }

  void changeVisibility(State<Test> state, int index) {
    switch (index) {
      case 3:
        state.setState(() {
          thirdPage = !thirdPage;
          fourthPage = false;
        });

      case 4:
        state.setState(() {
          thirdPage = false;
          fourthPage = !fourthPage;
          fifthPage = false;
        });
      case 5:
        state.setState(() {
          fourthPage = false;
          fifthPage = !fifthPage;
          sixthPage = false;
        });
      case 6:
        state.setState(() {
          fifthPage = false;
          sixthPage = !sixthPage;
          seventhPage = false;
        });
      case 7:
        state.setState(() {
          sixthPage = false;
          seventhPage = !seventhPage;
          eighthPage = false;
        });
      case 8:
        state.setState(() {
          seventhPage = false;
          eighthPage = !eighthPage;
        });
      case 9:
        state.setState(() {
          eighthPage = false;
        });
    }
  }

  bool check = false;
  bool checkColor = true;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          shadowColor: null,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: fromCssColor('#034DA3'),
            iconSize: 30,
            onPressed: () {
              if (step.currentPage == 3) {
                Navigator.pop(context);
              } else {
                step.deccriment();
                changeVisibility(this, step.currentPage);
              }
            },
          ),
          actions: [
            Visibility(
              visible: step.currentPage != 9,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 15),
                child: Text(
                  "Etape " + step.stepper(),
                  style: TextStyle(
                    fontSize: 20,
                    color: fromCssColor('#034DA3'),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Visibility(
                          visible: thirdPage,
                          child: ThirdPage(
                            formkey: formKey,
                            prenomController: prenomController,
                            nomController: nomController,
                          ),
                        ),
                        Visibility(
                          visible: fourthPage,
                          child: FourthPage(
                            formkey: formKey,
                            emailController: emailController,
                            passwordController: passwordController,
                          ),
                        ),
                        Visibility(
                          visible: fifthPage,
                          child: FifthPage(
                            formkey: formKey,
                            pinController: pinController,
                          ),
                        ),
                        Visibility(
                          visible: sixthPage,
                          child: SixethPage(
                            formkey: formKey,
                            formeJuridiqueController: formeJuridiqueController,
                            raisonSocialeController: raisonSocialController,
                            matriculeFiscaleController:
                                matriculeFiscaleController,
                          ),
                        ),
                        Visibility(
                          visible: seventhPage,
                          child: SeventhPage(
                            formkey: formKey,
                            siteWebController: siteWebController,
                            activitesController: activitesController,
                            addresseController: adresseController,
                          ),
                        ),
                        Visibility(
                          visible: eighthPage,
                          child: EighthPage(
                              image1Controller: image1Controller,
                              image2Controller: image2Controller,
                              image3Controller: image3Controller,
                              image4Controller: image4Controller),
                        ),
                        Visibility(
                          visible: step.currentPage == 9,
                          child: LastPage(
                            deviceId: deviceId,
                            reg: canSubmit == true ? reg : () {},
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Spacer(),
                        Visibility(
                          visible: step.currentPage == 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(child: checkBox()),
                              const SizedBox(
                                width: 10,
                              ),
                              const Flexible(
                                child: Text(
                                  'Je certifie étre le représentant légal de la société et habilité a signer au nom de la société',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: step.currentPage < 9,
                          child: MyButton(
                              btnText: 'Continuer',
                              btnColor: fromCssColor('#034DA3'),
                              txtColor: Colors.white,
                              onTap: () {
                                if (step.currentPage == 8) {
                                  print(pinController.text);
                                  if (check && imgCheck()) {
                                    step.incriment();
                                    changeVisibility(this, step.currentPage);
                                    setState(() {
                                      checkColor = true;
                                      check = false;
                                    });
                                  } else if (check && !imgCheck()) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CupertinoAlertDialog(
                                        content: const Text(
                                            "si vous n'avez pas tous les fichiers requis, votre profil ne sera pas vérifié tant que vous ne les aurez pas importer"),
                                        actions: [
                                          // Close the dialog
                                          CupertinoButton(
                                              child: const Text('confirmer'),
                                              onPressed: () {
                                                step.incriment();

                                                changeVisibility(
                                                    this, step.currentPage);
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
                                  }
                                  if (!check) {
                                    setState(() {
                                      checkColor = false;
                                    });
                                  }
                                } else if (step.currentPage == 4) {
                                  if (!formKey.currentState!.validate()) {
                                    formKey.currentState?.save();
                                    return;
                                  } else {
                                    sheckmail();
                                  }
                                } else if (!formKey.currentState!.validate()) {
                                  formKey.currentState?.save();
                                  return;
                                } else {
                                  step.incriment();
                                  changeVisibility(this, step.currentPage);
                                }
                              },
                              borderColor: Colors.transparent),
                        ),
                        Visibility(
                            visible: step.currentPage == 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  'Pas maintenat ? ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    step.incriment();
                                    changeVisibility(this, step.currentPage);
                                  },
                                  child: Text(
                                    'Skip',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: fromCssColor('#034DA3')),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
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

class ThirdPage extends StatefulWidget {
  final TextEditingController prenomController;
  final TextEditingController nomController;
  final GlobalKey<FormState> formkey;
  const ThirdPage(
      {super.key,
      required this.formkey,
      required this.prenomController,
      required this.nomController});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informations personnelles',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ',
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        ),
        const SizedBox(
          height: 60,
        ),
        Form(
          key: widget.formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Prénom',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: widget.prenomController,
                decoration: const InputDecoration(
                    hintText: 'Entrez voter prénom',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }

                  bool isAlphabet = RegExp(r'^[a-zA-Z ]+$').hasMatch(value);

                  if (!isAlphabet) {
                    return 'Seuls les caractères alphabétiques sont autorisés';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Nom',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: widget.nomController,
                decoration: const InputDecoration(
                    hintText: 'Entrez voter Nom', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }

                  bool isAlphabet = RegExp(r'^[a-zA-Z ]+$').hasMatch(value);

                  if (!isAlphabet) {
                    return 'Seuls les caractères alphabétiques sont autorisés';
                  }

                  return null;
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class FourthPage extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final GlobalKey<FormState> formkey;
  const FourthPage(
      {super.key,
      required this.formkey,
      required this.passwordController,
      required this.emailController});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informations personnelles',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ',
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        ),
        const SizedBox(
          height: 60,
        ),
        Form(
          key: widget.formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: widget.emailController,
                decoration: const InputDecoration(
                    hintText: 'Entrez voter Email',
                    border: OutlineInputBorder()),
                validator: ValidationBuilder().email().build(),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Mot de passe',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                controller: widget.passwordController,
                decoration: const InputDecoration(
                    hintText: 'Entrez voter mot de passe',
                    border: OutlineInputBorder()),
                validator: ValidationBuilder().minLength(8).build(),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class FifthPage extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController pinController;
  const FifthPage(
      {super.key, required this.formkey, required this.pinController});

  @override
  State<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  final pin1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Code pin',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ',
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        ),
        const SizedBox(
          height: 60,
        ),
        Form(
          key: widget.formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PIN (6 chiffres)',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              TextFormField(
                  controller: widget.pinController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'this field is required';
                    }

                    return null;
                  }),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Confirmer pin',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: pin1,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  if (pin1.text != widget.pinController.text) {
                    return 'the pin confirmation does not match ';
                  }
                  return null;
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SixethPage extends StatefulWidget {
  TextEditingController formeJuridiqueController;
  final TextEditingController raisonSocialeController;
  final TextEditingController matriculeFiscaleController;
  final GlobalKey<FormState> formkey;
  SixethPage(
      {super.key,
      required this.formkey,
      required this.formeJuridiqueController,
      required this.raisonSocialeController,
      required this.matriculeFiscaleController});

  @override
  State<SixethPage> createState() => _SixethPageState();
}

class _SixethPageState extends State<SixethPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informations profesionnelles',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ',
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        ),
        const SizedBox(
          height: 60,
        ),
        Form(
          key: widget.formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forme juridique',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              //----------------------------------------------------------------
              DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                    constraints: BoxConstraints(
                      maxHeight: 120,
                    )),
                items: const ['SARL', 'SuArl'],
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      hintText: "Choisissez votre forme juridique",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7))),
                ),
                onChanged: (value) {
                  setState(() {
                    widget.formeJuridiqueController.text = value!;
                  });
                },
                validator: (String? item) {
                  if (item == null) {
                    return 'Ce champ est obligatoire ';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Raison sociale',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: widget.raisonSocialeController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: ValidationBuilder().build(),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Matricule fiscale',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: widget.matriculeFiscaleController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: ValidationBuilder().build(),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SeventhPage extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController addresseController;
  final TextEditingController siteWebController;
  final TextEditingController activitesController;
  const SeventhPage(
      {super.key,
      required this.formkey,
      required this.addresseController,
      required this.siteWebController,
      required this.activitesController});

  @override
  State<SeventhPage> createState() => _SeventhPageState();
}

class _SeventhPageState extends State<SeventhPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informations profesionnelles',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ',
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        ),
        const SizedBox(
          height: 60,
        ),
        Form(
          key: widget.formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Address',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              //----------------------------------------------------------------

              TextFormField(
                controller: widget.addresseController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: ValidationBuilder().build(),
                /* (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }

                  bool isAlphabet = RegExp(r'^[a-zA-Z]+$').hasMatch(value);

                  if (!isAlphabet) {
                    return 'Seuls les caractères alphabétiques sont autorisés';
                  }

                  return null;
                }, */
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Site web',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: widget.siteWebController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: ValidationBuilder().build(),

                /* (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }

                  bool isAlphabet = RegExp(r'^[a-zA-Z]+$').hasMatch(value);

                  if (!isAlphabet) {
                    return 'Seuls les caractères alphabétiques sont autorisés';
                  }

                  return null;
                }, */
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Activités',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                    constraints: BoxConstraints(
                      maxHeight: 180,
                    )),
                items: const ['Service Informatique', 'Hotelerie', 'Autre'],
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      hintText: "Choisissez votre activité",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7))),
                ),
                onChanged: (value) {
                  setState(() {
                    widget.activitesController.text = value!;
                  });
                },
                validator: (String? item) {
                  if (item == null) {
                    return 'Ce champ est obligatoire ';
                  }
                  return null;
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class EighthPage extends StatefulWidget {
  TextEditingController image1Controller;
  TextEditingController image2Controller;
  TextEditingController image3Controller;
  TextEditingController image4Controller;
  EighthPage(
      {super.key,
      required this.image1Controller,
      required this.image2Controller,
      required this.image3Controller,
      required this.image4Controller});
  bool? test;

  @override
  State<EighthPage> createState() => _EighthPageState();
}

class _EighthPageState extends State<EighthPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.image1Controller.text != 'null' &&
        widget.image2Controller.text != 'null' &&
        widget.image3Controller.text != 'null' &&
        widget.image4Controller.text != 'null') {
      setState(() {
        widget.test = true;
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informations profesionnelles',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ',
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        ),
        const SizedBox(
          height: 60,
        ),
        ImagePick(
          imageController: widget.image1Controller,
          text: 'C.I.N Recto',
        ),
        const SizedBox(
          height: 15,
        ),
        ImagePick(
          imageController: widget.image2Controller,
          text: 'C.I.N Verso',
        ),
        const SizedBox(
          height: 15,
        ),
        ImagePick(
          imageController: widget.image3Controller,
          text: 'Patente',
        ),
        const SizedBox(
          height: 15,
        ),
        ImagePick(
          imageController: widget.image4Controller,
          text: 'Registre des entreprises',
        ),
      ],
    );
  }
}

class LastPage extends StatefulWidget {
  TextEditingController deviceId;
  final void Function() reg;
  LastPage({super.key, required this.deviceId, required this.reg});

  @override
  State<LastPage> createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  late bool firstChek = false;
  late bool secondChek = false;
  Future<void> initPlatformState() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      setState(() {
        widget.deviceId.text = androidDeviceInfo.id;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Conditions générales de ventes et d’utilisation",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna duis convallis convallis tellus id interdum velit laoreet. Vestibulum rhoncus est pellentesque elit. Ipsum faucibus vitae aliquet nec ullamcorper.Praesent elementum facilisis leo vel fringilla est ullamcorper eget. Ut ornare lectus sit amet est. Fringilla urna porttitor rhoncus dolor purus non. Amet tellus cras adipiscing enim eu turpis egestas pretium aenean.Egestas quis ipsum suspendisse ultrices gravida dictum. Lorem sed risus ultricies tristique nulla aliquet enim tortor. Mauris pellentesque pulvinar pellentesque habitant morbi tristique senectus. Viverra justo nec ultrices dui sapien eget mi proin sed. Commodo odio aenean sed adipiscing diam donec. Diam vel quam elementum pulvinar etiam non. Egestas quis ipsum suspendisse ultrices. Cursus mattis molestie a iaculis at.Vitae sapien pellentesque habitant morbi tristique. Pharetra sit amet aliquam id diam maecenas. Placerat in egestas erat imperdiet sed. Sodales ut etiam sit amet nisl. Venenatis tellus in metus vulputate eu scelerisque felis imperdiet. Adipiscing elit pellentesque habitant morbi tristique senectus et. Massa ultricies mi quis hendrerit dolor magna eget. Amet dictum sit amet justo donec enim. In nulla posuere sollicitudin aliquam ultrices sagittis. Elit ut aliquam purus sit amet luctus venenatis lectus. Ultrices mi tempus imperdiet nulla malesuada pellentesque elit.",
          softWrap: true,
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() {
                firstChek = !firstChek;
              }),
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: fromCssColor('#034DA3'),
                    )),
                child: firstChek
                    ? Icon(
                        Icons.check,
                        color: fromCssColor('#034DA3'),
                        size: 15,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            RichText(
              text: TextSpan(
                  text: "J’accepte",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                  ),
                  children: const [
                    TextSpan(
                      text: " les Termes et Conditions",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() {
                secondChek = !secondChek;
              }),
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: fromCssColor('#034DA3'),
                    )),
                child: secondChek
                    ? Icon(
                        Icons.check,
                        color: fromCssColor('#034DA3'),
                        size: 15,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            RichText(
              text: TextSpan(
                  text: "J’accepte",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                  ),
                  children: const [
                    TextSpan(
                      text: " la Politique de Confidentialité",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            SizedBox(
              height: 50,
              width: 120,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(
                  color: fromCssColor('#034DA3'),
                )),
                onPressed: () {},
                child: const Text(
                  'Refuser',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const Expanded(
              flex: 3,
              child: SizedBox.shrink(),
            ),
            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: fromCssColor('#034DA3'),
                ),
                onPressed: () async {
                  if (firstChek == true && secondChek == true) {
                    widget.reg();
                  }
                },
                child: const Text(
                  'Accepter',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
