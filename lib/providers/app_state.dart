import 'dart:convert';
import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MyAppState extends ChangeNotifier {
  // Kerrotaan dartille, että laitetaan arvo myöhemin mutta vain kerran:
  // late final String readAccessKey;
  var current = WordPair.random();
  String currentTitle = "";
  /////// Lisätty 25.3.2025
  bool isLoading = false;
  ////// Lisätty 25.3.2025
  List<String> titles = [];
  // Lisätty 27.3.2025
  List<Movie> movies = [];
  List<WordPair> favorites = <WordPair>[];
  // late final String readAccessKey;

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Enviä ei jäsenmuuttujaksi!!! 1.4.2025 --> Tämän debuggausta oli (vaikka aluksi olin laittanut oikein --> Merkitse oppimispäiväkirjaan!!!)
  // MyAppState() {
  //   String? key = dotenv.env['API_KEY'];

  //   if (key == null) {
  //     throw Exception(
  //         "No read access key found in app_state init, does .env file exist?");
  //   }
  //   readAccessKey = key;
  // }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  // void setIsLoading(bool isLoading) {
  //   this.isLoading = isLoading;
  //   notifyListeners();
  // }

  // API-metodi:
  Future<List<Movie>> getPopularMovies() async {
    // setIsLoading(isLoading = true);
    
    // Jos elokuvia ei sovelluksen käynnissäoloaikana ole vielä haettu,
    // siirrytään ehtolauseen toteutusosaan:
    // if (titles.isEmpty) {
      final Uri url = Uri.parse("https://api.themoviedb.org/3/movie/popular");

      // Normaalisti API-avain laitettaisiin ympäristömuuttujiin:
      http.Response response = await http.get(url, headers: {
        "Authorization": "Bearer ${dotenv.env['API_KEY']}",
        "Accepts": "application/json",
        "Content-Type": "application/json"
      });

      // body-jäsen pitää sisällään JSON-datan merkkijonomuodossa:
      var data = jsonDecode(response.body) as Map<String, dynamic>;


      // Tämä muutettin movies-nimestä, jotta saatiin 
      // movies-niminen jäsenmuuttuja 27.3.
      List moviesJsonList = data["results"];

      // Tämä lisättiin 27.3.
      // movies = moviesJsonList.map((movieJson) => Movie.fromJson(movieJson)).toList();
      return moviesJsonList.map((movieJson) => Movie.fromJson(movieJson)).toList();

      // map-metodi ottaa parametriksi callback-funktion.
      // // Tässä voitaisiin käyttää myös as String, jolloin tyyppimäärittelyä
      // map-metodin suhteen ei tarvita.
    //   titles = moviesJsonList.map<String>((movie) {
    //     return movie["original_title"];
    //   }).toList();
    // }

    // // Listalla on first- ja last-getterit eli ei tarvitse pelailla
    // // indekseillä. Haetaan nyt kuitenkin currentTitle-muuttujaan
    // // titles-listasta satunnainen alkio:
    // currentTitle = titles[Random().nextInt(titles.length)];
    // setIsLoading(isLoading = false);

    // // Kutsutaan notifyListeners-funktiota, jotta tähän API-funktioon
    // // liittyvän widgetin build-metodia kutsutaan:
    // notifyListeners();
  }
}
