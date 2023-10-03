import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

class CarteBancaire extends StatefulWidget {
  final void Function() Tap;
  final Color color;
  const CarteBancaire({super.key, required this.Tap, required this.color});

  @override
  State<CarteBancaire> createState() => _CarteBancaireState();
}

class _CarteBancaireState extends State<CarteBancaire> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: widget.color, width: 1.5)),
        elevation: 8,
        shadowColor: Colors.grey[200],
        child: InkWell(
          onTap: () {
            widget.Tap();
          },
          child: Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Solde actuel'),
                      Text('Visa'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: fromCssColor('#92C3FF'),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(7.0),
                          child: Text(
                            'TND',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('3250.00'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Text('**** **** **** 1234'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Marcus Alexander'),
                      Text('09/23'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
