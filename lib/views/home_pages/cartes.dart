import 'package:flutter/material.dart';

import 'comptes_bancaires.dart';

class Carte extends StatefulWidget {
  const Carte({super.key});

  @override
  State<Carte> createState() => _CarteState();
}

class _CarteState extends State<Carte> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Cartes et comptes bancaire',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
                child: TabBar(
                  indicator: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0,
                      )
                    ],
                    color: Colors.white,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  labelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'Comptes bancaires',
                    ),
                    Tab(
                      text: 'Cartes bancaires',
                    )
                  ],
                ),
              ),
            ),
            const Expanded(
                child: TabBarView(
              children: [
                Comptesbancaires(),
                Comptesbancaires(),
              ],
            ))
          ]),
        ),
      ),
    );
  }
}
