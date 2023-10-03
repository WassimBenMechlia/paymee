import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/views/home_pages/carte_bancaire_info/ajouter_une_carte.dart';
import 'package:paymee/widgets/buttons.dart';
import 'package:paymee/widgets/carteBancaire.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCode extends StatefulWidget {
  final Barcode? result;
  final QRViewController? controller;

  const QrCode({super.key, required this.result, required this.controller});

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  void _handleTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void dispose() {
    widget.controller?.resumeCamera();
    super.dispose();
  }

  payer(BuildContext context) {
    if (selectedIndex < 0) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error message'),
          backgroundColor: Colors.red,
        ));
      });
    }
  }

  late int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Choisissez une carte',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: fromCssColor('#034DA3'),
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline_rounded),
              color: fromCssColor('#034DA3'),
              iconSize: 30,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AjoutCarte())));
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return CarteBancaire(
                    color: selectedIndex == index
                        ? Colors.blue
                        : Colors.transparent,
                    Tap: () => _handleTap(index),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyButton(
                  btnText: 'Payer',
                  btnColor: fromCssColor('#034DA3'),
                  txtColor: Colors.white,
                  onTap: () {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Error message'),
                        backgroundColor: Colors.red,
                      ));
                    });
                  },
                  borderColor: Colors.transparent),
            )
          ],
        ),
      ),
    );
  }
}
