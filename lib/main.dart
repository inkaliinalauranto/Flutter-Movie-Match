import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/app_state.dart';
import 'package:flutter_app/providers/moviematch.dart';
import 'package:flutter_app/views/favorites_page.dart';
import 'package:flutter_app/views/generator_page.dart';
import 'package:flutter_app/views/start_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
// Ios-paketti, joka on Flutteriin sisäänrakennettu:

Future<void> main() async {
  // Annetaan tiedostonimi nimettynä parametrina:
  await dotenv.load(fileName: '.env');
  // runApp(MyApp());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MyAppState()),
    ChangeNotifierProvider(create: (_) => MovieMatchProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      routerConfig: GoRouter(routes: [
        GoRoute(
          path: "/movies",
          builder: (context, state) {
            return MyHomePage(
              child: GeneratorPage(),
            );
          },
        ),
        GoRoute(
            path: "/favorites",
            builder: (context, state) {
              return MyHomePage(
                child: FavoritesPage(),
              );
            }),
        GoRoute(
            path: "/",
            builder: (context, state) {
              return MyHomePage(child: StartPage());
            })
      ]),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // Lisätty
  final Widget? child;
  // Now class _MyHomePageState has now widget.child

  // Lisätty
  const MyHomePage({this.child});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Lisätään tänne platformSpesificin mahdollistavia muuttujia 20.3.
    if (Platform.isAndroid) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: widget.child,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).colorScheme.inverseSurface,
          unselectedItemColor: Theme.of(context).colorScheme.inverseSurface,
          items: [
                BottomNavigationBarItem(
                    icon: GestureDetector(
                      child: Icon(Icons.person_2_outlined),
                      onTap: () => {context.go("/")},
                    ),
                    label: "Identify"),
                BottomNavigationBarItem(
                  icon: GestureDetector(
                    child: Icon(Icons.movie_outlined),
                    onTap: () => {context.go("/movies")},
                  ),
                  label: 'Movies',
                ),
                BottomNavigationBarItem(
                  icon: GestureDetector(
                    child: Icon(Icons.favorite_outline),
                    onTap: () => {context.go("/favorites")},
                  ),
                  label: 'Favorites',
                ),
              ],),
      );
    }

    // Katsotaan, miltä näyttääm his kautetaan !isIos ja sama Androidille
    // jos halutaan tehdä natiivin näköisiä sovelluksia, niin koodia tulee
    // paljon, jolloin voi miettiä, onko järkevää tehdä Flutterilla
    // Kaikista paras on tehdä sellainen sovellus tästä, joka ei näytä mitlään
    // käyttöjärjestelmälältä
    if (Platform.isIOS) {
      // Asennetaan tätä varten cupertino
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar.large(
          largeTitle: Text("Large Navigation Bar"),
        ),
        child: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Child"),
          ],
        ))),
      );
    }

    return Container();
  }
}

class CustomNavigationRail extends StatelessWidget {
  const CustomNavigationRail({
    super.key,
    required this.widget,
  });

  final MyHomePage widget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: constraints.maxWidth >= 600,
              destinations: [
                NavigationRailDestination(
                    icon: GestureDetector(
                      child: Icon(Icons.person),
                      onTap: () => {context.go("/")},
                    ),
                    label: Text("Set username")),
                NavigationRailDestination(
                  icon: GestureDetector(
                    child: Icon(Icons.home),
                    onTap: () => {context.go("/home")},
                  ),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: GestureDetector(
                    child: Icon(Icons.favorite),
                    onTap: () => {context.go("/favorites")},
                  ),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: null,
              // onDestinationSelected: (value) {
              //   setState(() {
              //     selectedIndex = value;
              //   });
              // },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: widget.child,
            ),
          ),
        ],
      );
    });
  }
}
