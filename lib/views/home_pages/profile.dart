import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:paymee/widgets/profle_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../welcome_page.dart';
import 'information/informations_personnelles.dart';
import 'information/informations_societe.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const Informations();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'InfoSociete',
            builder: (BuildContext context, GoRouterState state) {
              return const InformationSociete();
            },
          ),
          GoRoute(
            path: 'InfoPersonnelles',
            builder: (BuildContext context, GoRouterState state) {
              return const InfoPersonnelles();
            },
          ),
        ],
      ),
      /*    GoRoute(
        path: 'InfoSociete',
        builder: (BuildContext context, GoRouterState state) {
          return const InformationSociete();
        },
      ),
      GoRoute(
        path: 'InfoPersonnelles',
        builder: (BuildContext context, GoRouterState state) {
          return const InfoPersonnelles();
        },
      ), */
    ],
  );
}

class Informations extends StatefulWidget {
  const Informations({super.key});

  @override
  State<Informations> createState() => _InformationsState();
}

class _InformationsState extends State<Informations> {
  @override
  Widget build(BuildContext context) {
    List<String> texts = [
      'Informations de la société',
      'Informations personnelles',
      'Changer mot de passe',
      'Notifications',
      'Reconnaissance faciale',
      'Empreintes',
    ];
    List<String> routeList = [
      'InfoSociete',
      'InfoPersonnelles',
      /*'changerMotDePasse',
      'notifications',
      'reconnaissanceFaciale',
      'empreintes', */
    ];
    double screenWidth = (MediaQuery.of(context).size.width) / 2;
    print((MediaQuery.of(context).size.width) / 2);

    Future<void> logout() async {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          /* title: const Text("Title"), */
          content: const Text("êtes-vous sûr de vouloir quitter"),
          actions: [
            // Close the dialog
            CupertinoButton(
                child: const Text('confirmer'),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove('token');
                  prefs.remove('response');
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const Welcome())));
                }),
            CupertinoButton(
                child: const Text('annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      );
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/profilebackground.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 35, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            logout();
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset('assets/images/plogo.png'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Text('Paymee',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const Divider(
                      color: Colors.blue,
                      thickness: 2,
                    ),
                    ListView.builder(
                        itemCount: 6,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return ProfileCard(
                            GoTo: () {
                              context.go('/${routeList[index]}');
                            },
                            text: texts[index],
                          );
                        }))
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
