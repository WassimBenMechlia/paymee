import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/widgets/transaction_card.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Transactions',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Récent ',
                          style: TextStyle(
                            color: fromCssColor('#99A2AD'),
                          ),
                        )),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return const TransactionCard();
                      },
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Plus encien ',
                          style: TextStyle(
                            color: fromCssColor('#99A2AD'),
                          ),
                        )),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return const TransactionCard();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
