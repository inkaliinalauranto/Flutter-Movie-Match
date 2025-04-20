import 'package:flutter_app/providers/movie_match_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test setUsername", () {
    test("Should be Muumipeikko", () {
      final MovieMatchProvider movieMatchProvider = MovieMatchProvider();

      movieMatchProvider.setUserName("Muumipeikko");

      expect(movieMatchProvider.userName, "Muumipeikko");
    });

    test("Should be Nuuskamuikkunen", () {
      final MovieMatchProvider movieMatchProvider = MovieMatchProvider();

      movieMatchProvider.setUserName("Nuuskamuikkunen");

      expect(movieMatchProvider.userName, "Nuuskamuikkunen");
    });
  });
}
