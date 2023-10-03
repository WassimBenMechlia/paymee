import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorMessage extends StatelessWidget {
  final String error;
  const ErrorMessage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Text(error),
      actions: [
        // Close the dialog
        CupertinoButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
          color: Colors.transparent,
          height: 100,
          child: Center(
            child: Lottie.asset('assets/loading/secondanimation.json',
                frameRate: FrameRate(600)),
          )),
    );
  }
}
