import 'package:flutter/material.dart';
import 'package:flutter_app/providers/app_state.dart';
import 'package:flutter_app/providers/moviematch.dart';
import 'package:flutter_app/views/generator_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';


void main() {
  testWidgets('Verify Next button is found', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => MyAppState()),
      ChangeNotifierProvider(create: (_) => MovieMatchProvider())
    ], child: MaterialApp(home: GeneratorPage())));

    expect(find.widgetWithText(ElevatedButton, "Next"), findsOneWidget);
  });
}
