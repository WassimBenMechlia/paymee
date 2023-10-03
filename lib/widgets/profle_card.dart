import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String text;
  final void Function() GoTo;

  const ProfileCard({super.key, required this.text, required this.GoTo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: GestureDetector(
        onTap: GoTo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.blue[900],
            )
          ],
        ),
      ),
    );
  }
}
