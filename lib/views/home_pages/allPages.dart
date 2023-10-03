// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:paymee/views/home_pages/Scanner.dart';
import 'package:paymee/views/home_pages/profile.dart';
import 'package:paymee/views/home_pages/transactions.dart';
import 'package:paymee/views/home_pages/virements.dart';
import '../../widgets/bottomnavigationbar_items.dart';
import 'cartes.dart';
import 'home.dart';

class AllPages extends StatefulWidget {
  const AllPages({
    super.key,
  });

  @override
  State<AllPages> createState() => _AllPagesState();
}

class _AllPagesState extends State<AllPages> {
  //save sharedprefs in a model :

  int pageIndex = 0;
  List<bool> pages = [
    true,
    false,
    false,
    false,
    false,
    false,
  ];
  int prevPgaIndex = 0;

  @override
  Widget build(BuildContext context) {
    void changepages(index) {
      pages[prevPgaIndex] = false;
      pages[index] = true;
      prevPgaIndex = index;
    }

    List<String> icons = [
      'Acceuil',
      'Transactions',
      'Virements',
      'Scanner',
      'Cart',
      'Profile'
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 11,
              child: Stack(
                children: [
                  Visibility(
                    visible: pages[0],
                    child: Home(
                        recentTransactions: 4,
                        voirTous: () {
                          changepages(1);
                          setState(() {
                            pageIndex = 1;
                          });
                        }),
                  ),
                  Visibility(
                    visible: pages[1],
                    child: const Transactions(),
                  ),
                  Visibility(
                    visible: pages[2],
                    child: const Virements(),
                  ),
                  Visibility(
                    visible: pages[3],
                    child: const Scanner(),
                  ),
                  Visibility(
                    visible: pages[4],
                    child: const Carte(),
                  ),
                  Visibility(
                    visible: pages[5],
                    child: const Profile(),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    itemBuilder: ((context, index) {
                      return NavItem(
                        changePage: () {
                          changepages(index);
                          setState(() {
                            pageIndex = index;
                          });
                        },
                        Color: index == pageIndex
                            ? fromCssColor('#034DA3')
                            : fromCssColor('#99A2AD'),
                        icon: icons[index],
                      );
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
