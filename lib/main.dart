import 'package:flutter/material.dart';
import 'package:flutter_app/providers/app_state.dart';
import 'package:flutter_app/providers/movie_match_provider.dart';
import 'package:flutter_app/views/match_page.dart';
import 'package:flutter_app/views/generator_page.dart';
import 'package:flutter_app/views/my_home_page.dart';
import 'package:flutter_app/views/start_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
            path: "/matches",
            builder: (context, state) {
              return MyHomePage(
                child: MatchPage(),
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
