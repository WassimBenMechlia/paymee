import 'dart:math';

import 'package:flutter/material.dart';

// KeyPad widget
// This widget is reusable and its buttons are customizable (color, size)
class NumPad extends StatelessWidget {
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;

  const NumPad({
    Key? key,
    required this.delete,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    int rand = random.nextInt(10) + 3;
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: NumberButton(
                  number: (1 + rand) % 10,
                  controller: controller,
                ),
              ),
              const Spacer(),
              NumberButton(
                number: (2 + rand) % 10,
                controller: controller,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: NumberButton(
                  number: (3 + rand) % 10,
                  controller: controller,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: NumberButton(
                  number: (4 + rand) % 10,
                  controller: controller,
                ),
              ),
              const Spacer(),
              NumberButton(
                number: (5 + rand) % 10,
                controller: controller,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: NumberButton(
                  number: (6 + rand) % 10,
                  controller: controller,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: NumberButton(
                  number: (7 + rand) % 10,
                  controller: controller,
                ),
              ),
              const Spacer(),
              NumberButton(
                number: (8 + rand) % 10,
                controller: controller,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: NumberButton(
                  number: (9 + rand) % 10,
                  controller: controller,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  onPressed: () => delete(),
                  icon: const Icon(
                    Icons.backspace,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(),
              NumberButton(
                number: (0 + rand) % 10,
                controller: controller,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  onPressed: () => onSubmit(),
                  icon: const Icon(
                    Icons.done_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// define NumberButton widget
// its shape is round
class NumberButton extends StatelessWidget {
  final int number;

  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        child: InkWell(
          onTap: () {
            controller.text.length <= 5
                ? controller.text += number.toString()
                : null;
          },
          child: SizedBox(
            width: 56,
            height: 56,
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
          ),
        ),
      ),
    );
    /* InkWell(
        onTap: () {
          controller.text.length <= 5
              ? controller.text += number.toString()
              : null;
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              number.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
        ),
      ), */
  }
}
