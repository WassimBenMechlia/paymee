// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/controllers/ApiException.dart';
import 'package:paymee/views/home_pages/verifying.dart';
import 'package:paymee/views/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/shared_user_info.dart';
import '../../controllers/apiServices.dart';
import '../../widgets/alertdialogs.dart';
import '../../widgets/buttons.dart';
import '../../widgets/image.dart';

class UnverifiedAcc extends StatefulWidget {
  final UserProfile profile;
  const UnverifiedAcc({super.key, required this.profile});

  @override
  State<UnverifiedAcc> createState() => _UnverifiedAccState();
}

class _UnverifiedAccState extends State<UnverifiedAcc> {
  bool clickable = true;
  void showLoading() {
    clickable = !clickable;

    loadingOverlay = OverlayEntry(
      builder: (context) => const Center(
        child: LoadingCircle(),
      ),
    );
    Overlay.of(context).insert(loadingOverlay!);
  }

  OverlayEntry? loadingOverlay;

  void hideLoading() {
    clickable = !clickable;

    loadingOverlay!.remove();
    loadingOverlay = null;
  }

  final image1Controller = TextEditingController();
  final image2Controller = TextEditingController();
  final image3Controller = TextEditingController();
  final image4Controller = TextEditingController();
  Future<void> addFiles(FormData formData) async {
    print(widget.profile.idFront);
    widget.profile.idFront == null
        ? image1Controller.text.isEmpty
            ? null
            : formData.files.add(MapEntry(
                'cin_img_recto.jpg',
                await MultipartFile.fromFile(image1Controller.text,
                    filename: 'cinRecto',
                    contentType: MediaType('image', 'jpg'))))
        : null;

    widget.profile.idBack == null
        ? image2Controller.text.isEmpty
            ? null
            : formData.files.add(MapEntry(
                'cin_img_verso.jpg',
                await MultipartFile.fromFile(image2Controller.text,
                    filename: 'cinVerso',
                    contentType: MediaType('image', 'jpg'))))
        : null;
    widget.profile.businessNumber == null
        ? image3Controller.text.isEmpty
            ? null
            : formData.files.add(MapEntry(
                'business_number.jpg',
                await MultipartFile.fromFile(image3Controller.text,
                    filename: 'businessNumber',
                    contentType: MediaType('image', 'jpg'))))
        : null;
    widget.profile.businessTax == null
        ? image4Controller.text.isEmpty
            ? null
            : formData.files.add(MapEntry(
                'business_tax.jpg',
                await MultipartFile.fromFile(image4Controller.text,
                    filename: 'businessTax',
                    contentType: MediaType('image', 'jpg'))))
        : null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.profile.idFront != null
        ? image1Controller.text = widget.profile.idFront
        : null;
    widget.profile.idBack != null
        ? image2Controller.text = widget.profile.idBack
        : null;
    widget.profile.businessNumber != null
        ? image3Controller.text = widget.profile.businessNumber!
        : null;
    widget.profile.businessTax != null
        ? image4Controller.text = widget.profile.businessTax!
        : null;
  }

  APIService api = APIService();

  Future<void> sendDocs() async {
    print(image1Controller.text);

    final prefs = await SharedPreferences.getInstance();

    String? json = prefs.getString('response');
    AuthResponse? authData;

    if (json != null) {
      authData = AuthResponse.fromJson(jsonDecode(json));
    }
    String? token = authData?.data.first.token;
    print("$token--------");
    var formData = FormData();
    await addFiles(formData);

    /*   image1Controller.text.isEmpty
        ? formData.fields.add(MapEntry('cin_img_recto', ''))
        : formData.files.add(MapEntry(
            'cin_img_recto',
            await MultipartFile.fromFile(image1Controller.text,
                filename: 'cinRecto', contentType: MediaType('image', 'jpg'))));
    image2Controller.text.isEmpty
        ? formData.fields.add(MapEntry('cin_img_verso', ''))
        : formData.files.add(MapEntry(
            'cin_img_verso',
            await MultipartFile.fromFile(image2Controller.text,
                filename: 'cinVerso', contentType: MediaType('image', 'jpg'))));
    image3Controller.text.isEmpty
        ? formData.fields.add(MapEntry('business_number', ''))
        : formData.files.add(MapEntry(
            'business_number',
            await MultipartFile.fromFile(image3Controller.text,
                filename: 'businessNumber',
                contentType: MediaType('image', 'jpg'))));
    image4Controller.text.isEmpty
        ? formData.fields.add(MapEntry('business_tax', ''))
        : formData.files.add(MapEntry(
            'business_tax',
            await MultipartFile.fromFile(image4Controller.text,
                filename: 'businessTax',
                contentType: MediaType('image', 'jpg')))); */

    /*   FormData formdata = FormData.fromMap({
      'cin_img_recto': await MultipartFile.fromFile(image1Controller.text,
          filename: 'CinRecto', contentType: MediaType('image', 'jpg')),
      'cin_img_verso': await MultipartFile.fromFile(image2Controller.text,
          filename: 'CinVerso', contentType: MediaType('image', 'jpg')),
      'business_number': await MultipartFile.fromFile(image3Controller.text,
          filename: 'BusinessNumber', contentType: MediaType('image', 'jpg')),
      'business_tax': await MultipartFile.fromFile(image4Controller.text,
          filename: 'BusinessNumber', contentType: MediaType('image', 'jpg')),
    }); */
    try {
      print(widget.profile.toString());
      showLoading();
      print(formData.files);
      await api.completeFiles(formData, token);

      print(image1Controller.text);
      hideLoading();
      if (image1Controller.text.isNotEmpty &&
          image2Controller.text.isNotEmpty &&
          image3Controller.text.isNotEmpty &&
          image4Controller.text.isNotEmpty) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const VerifyingAcc(),
            ));
      }
    } on ApiException catch (e) {
      hideLoading();
      showDialog(
          context: context,
          builder: (context) => ErrorMessage(
                error: e.message,
              ));
    }
  }

  Future<void> logout() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        /* title: const Text("Title"), */
        content: const Text("êtes-vous sûr de vouloir quitter"),
        actions: [
          // Close the dialog
          CupertinoButton(
              child: const Text('confirmer'),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                prefs.remove('response');
                Navigator.of(context).pop();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => const Welcome())));
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () async {
                    await logout();
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.black,
                  ))
            ],
          ),
          body: LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'NB !',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              const Text(
                                'vous ne pouvez bénéficier des services Paymee sauf si vous complétez tous les dossiers requis :',
                                style: TextStyle(fontSize: 17),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              Visibility(
                                visible: image1Controller.text.isEmpty,
                                child: ImagePick(
                                  imageController: image1Controller,
                                  text: 'C.I.N Recto',
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Visibility(
                                visible: image2Controller.text.isEmpty,
                                child: ImagePick(
                                  imageController: image2Controller,
                                  text: 'C.I.N Verso',
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Visibility(
                                visible: image3Controller.text.isEmpty,
                                child: ImagePick(
                                  imageController: image3Controller,
                                  text: 'Patente',
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Visibility(
                                visible: image4Controller.text.isEmpty,
                                child: ImagePick(
                                  imageController: image4Controller,
                                  text: 'Registre des entreprises',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Spacer(),
                              MyButton(
                                  btnText: 'Continuer',
                                  btnColor: fromCssColor('#034DA3'),
                                  txtColor: Colors.white,
                                  onTap: () async {
                                    sendDocs();
                                  },
                                  borderColor: Colors.transparent)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }
}
