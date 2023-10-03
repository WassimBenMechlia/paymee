import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

import '../../widgets/transaction_card.dart';

class Home extends StatefulWidget {
  final int recentTransactions;
  final void Function() voirTous;
  const Home(
      {super.key, required this.recentTransactions, required this.voirTous});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Image image1;
  @override
  void initState() {
    super.initState();

    image1 = Image.asset("assets/images/paymeeback.png");
  }

  @override
  void didChangeDependencies() {
    // Adjust the provider based on the image type
    precacheImage(image1.image, context);
    super.didChangeDependencies();
  }

  bool haveNotification = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(image: image1.image, fit: BoxFit.cover),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bonjour,',
                              style: TextStyle(
                                  color: fromCssColor('#AFD5FD'), fontSize: 25),
                            ),
                            const Text(
                              'Paymee',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: haveNotification
                              ? Image.asset(
                                  'assets/images/havenotification.png')
                              : Image.asset(
                                  'assets/images/notificationicon.png'),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Solde actuel',
                          style: TextStyle(
                              color: fromCssColor('#AFD5FD'), fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              '3,250.003',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 35),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: fromCssColor('#92C3FF'),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Text(
                                  'TND',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Container(
                      height: 35,
                      color: Colors.white,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 15, left: 15, top: 15),
                        child: Row(
                          children: [
                            Text(
                              'Transactions',
                              style: TextStyle(
                                color: fromCssColor('#99A2AD'),
                                fontSize: 17,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                widget.voirTous();
                              },
                              child: Text(
                                'Voir tous',
                                style: TextStyle(
                                  color: fromCssColor('#034DA3'),
                                  fontSize: 17,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      /* height: double.infinity,*/
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                            itemCount: widget.recentTransactions,
                            itemBuilder: (context, index) {
                              return const TransactionCard();
                            }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
