import 'package:flutter/material.dart';
import 'package:flutter_app/providers/app_state.dart';
import 'package:flutter_app/providers/movie_match_provider.dart';
import 'package:flutter_app/views/start_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';


void main() {
  testWidgets('Verify Change button is found', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => MyAppState()),
      ChangeNotifierProvider(create: (_) => MovieMatchProvider())
    ], child: MaterialApp(home: StartPage())));

    await tester.pumpAndSettle();

    expect(find.widgetWithText(ElevatedButton, "Change"), findsOneWidget);
  });
}
