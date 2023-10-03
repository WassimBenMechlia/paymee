import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              FittedBox(
                child: Text('1'),
              ),
              FittedBox(
                child: Text('2'),
              ),
              FittedBox(
                child: Text('3'),
              ),
            ],
          ),
          Row(
            children: [
              FittedBox(
                child: Text('4'),
              ),
              FittedBox(
                child: Text('5'),
              ),
              FittedBox(
                child: Text('6'),
              ),
            ],
          ),
          Row(
            children: [
              FittedBox(
                child: Text('7'),
              ),
              FittedBox(
                child: Text('8'),
              ),
              FittedBox(
                child: Text('9'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
