import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String btnText;
  final Color btnColor;
  final Color txtColor;
  final Color borderColor;

  final void Function()? onTap;

  const MyButton(
      {super.key,
      required this.btnText,
      required this.btnColor,
      required this.txtColor,
      required this.onTap,
      required this.borderColor});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: widget.btnColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: widget.borderColor, width: 1)),
          child: Center(
            child: Text(
              widget.btnText,
              style: TextStyle(color: widget.txtColor, fontSize: 18),
            ),
          )),
    );
  }
}
