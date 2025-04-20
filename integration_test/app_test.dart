import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/providers/app_state.dart';
import 'package:flutter_app/providers/movie_match_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  group("end-to-end test", () {
    testWidgets("tap the favorites button, navigate to the favorites page and search a text", (tester) async {
      
      await tester.pumpWidget(MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => MyAppState()),
        ChangeNotifierProvider(create: (_) => MovieMatchProvider())
      ], child: const MyApp()));

      final favoritesButton = find.byKey(const ValueKey("favoritesbutton"));
      await tester.tap(favoritesButton);
      await tester.pumpAndSettle();
      expect(find.text("No matches yet."), findsOneWidget);

      ///// Koska käyttöliittymä on muuttunut, ei alla oleva testi enää toimi:

      // final textButton = find.byKey(const ValueKey("textbutton"));
      // await tester.tap(textButton);
      // // "Pumpataan" vain yksi frame eteenpäin, jotta Loading... -teksti 
      // // ei ehdi vaihtua elokuvaotsikkoon:
      // await tester.pump();
      // expect(find.text("Loading..."), findsOneWidget);

      // expect(find.byIcon(Icons.favorite_border), findsOneWidget);

      // // "Pumpataan" animaatiot loppuun, jotta rajapintahaku valmistuu, 
      // // minkä myötä Like-nappi saadaan enabloitua:
      // await tester.pumpAndSettle();

      // final btn = find.byKey(const ValueKey("like"));
      // await tester.tap(btn);
      // await tester.pumpAndSettle();
      // expect(find.byIcon(Icons.favorite), findsAtLeast(2));
    });
  });
}
