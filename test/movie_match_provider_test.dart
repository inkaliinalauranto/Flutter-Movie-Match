import 'package:flutter_app/providers/movie_match_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test setUsername", () {
    test("Should be Muumipeikko", () {
      final MovieMatchProvider movieMatchProvider = MovieMatchProvider();

      movieMatchProvider.setUsername("Muumipeikko");

      expect(movieMatchProvider.getUsername(), "Muumipeikko");
    });

    test("Should be Nuuskamuikkunen", () {
      final MovieMatchProvider movieMatchProvider = MovieMatchProvider();

      movieMatchProvider.setUsername("Nuuskamuikkunen");

      expect(movieMatchProvider.getUsername(), "Nuuskamuikkunen");
    });
  });
}
