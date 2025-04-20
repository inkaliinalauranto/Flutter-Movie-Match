import 'dart:io';
// iOS:n Cupertino-pakettin löytyy Flutterista sisäänrakennettuna:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  // Lisätty
  final Widget? child;
  // class _MyHomePageState has now widget.child

  // Lisätty
  const MyHomePage({this.child});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Tässä kohtaa on mahdollista luoda alustakohtaista koodia.
    // Tätä tehtiin 20.3.
    if (Platform.isAndroid) {
      return Scaffold(
        backgroundColor: colorScheme.primaryContainer,
        body: widget.child,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: colorScheme.inverseSurface,
          unselectedItemColor: colorScheme.inverseSurface,
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

    // Jos halutaan katsoa, miltä sovellus näyttää iOS-käyttöjärjestelmässä, 
    // lisätään alla- ja ylläolevien ehtolause-ehtojen eteen huutomerkki. 
    // Jos järjestelmäriippumattomasta sovelluksen ulkonäkö halutaan tehdä 
    // natiivikäyttöjärjestelmien ulkoasuja mukaillen, koodia tulee paljon. 
    // Tällaisessa tilanteessa onkin järkevää miettiä, kannattaako sovellus 
    // tehdä kummallekin käyttöjärjestelmälle erikseen. Kaikista järkevintä 
    // olisikin tehdä sovellus, jonka tyyli on käyttöjärjestelmäriippumaton. 
    if (Platform.isIOS) {
      // CupertinoPageScaffold on haettava cupertino-paketista:
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