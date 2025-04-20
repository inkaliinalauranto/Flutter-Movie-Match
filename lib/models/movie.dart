class Movie {
  // Muuttujien nimeämisissä käytetään PascalCase-käytäntöä Flutterin 
  // syntaksin mukaisesti: 
  final int id;
  final String originalTitle;
  final String posterPath;
  final DateTime releaseDate;

  Movie(
      {required this.id,
      required this.originalTitle,
      required this.posterPath,
      required this.releaseDate});

  // Nimetty rakentaja muodostetaan pistenotaation avulla siten, että 
  // luokan jäsenmuuttujiin asetetaan arvot kaksoispisteen jälkeen alla 
  // koodatun mukaisesti. 
  //
  // Huom! Map on tietotyyppi, joka sisältää avain-arvo-pareja. Jokainen 
  // json-muuttujan avain on tietotyypiltään string ja avainten tietotyypit 
  // voivat vaihdella: 
  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        originalTitle = json["original_title"],
        posterPath = json["poster_path"],
        // Konvertoidaan päivämäärä DateTime-luokaksi:
        releaseDate = DateTime.parse(json["release_date"]);
}


/* Luokan myötä saadaan selkeä ja siisti tapa päästä käsiksi dataan.
 * Tämä on myös performanssimielessä susoiteltua, koska tämän myötä ei 
 * datatyyppejä tarvitse korjata. Nyt Movie-luokkaa voidaan siis hyödyntää 
 * MyAppStatessa.
 */

