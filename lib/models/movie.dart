class Movie {
  final int id;
  // Käytetään pascal styleä Flutterin syntaksn mukaisesti, vaikka JSON:ssa 
  // sanojen erottelu tapahtuu alaviivalla: 
  final String originalTitle;
  final String posterPath;
  final DateTime releaseDate;

  Movie(
      {required this.id,
      required this.originalTitle,
      required this.posterPath,
      required this.releaseDate});

  // Nimetty rakentaja toteutetaan kaksoispisteen avulla:
  // json on siis Map-tietotyyppiä, joka pitää sisällän avain-arvo-pareja:
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

