import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MyAppState extends ChangeNotifier {
  // Määritellään, että muuttujaan asetetaan arvo myöhemmin ja vain kerran:
  // late final String readAccessKey;
  List<Movie> movies = [];

  /////////////////////////////////////////////////////////////////////////////
  // Jotta testit suorituivat, ei API_KEY:n arvoa voitu rakentajassa hakea:
  // MyAppState() {
  //   String? key = dotenv.env['API_KEY'];

  //   if (key == null) {
  //     throw Exception(
  //         "No read access key found in app_state init, does .env file exist?");
  //   }
  //   readAccessKey = key;
  // }
  /////////////////////////////////////////////////////////////////////////////

  // API-metodi:
  Future<List<Movie>> getPopularMovies() async {
      final Uri url = Uri.parse("https://api.themoviedb.org/3/movie/popular");

      http.Response response = await http.get(url, headers: {
        "Authorization": "Bearer ${dotenv.env['API_KEY']}",
        "Accepts": "application/json",
        "Content-Type": "application/json"
      });

      // body-jäsen pitää sisällään JSON-datan merkkijonomuodossa:
      var data = jsonDecode(response.body) as Map<String, dynamic>;


      // Tämä muutettin movies-nimestä 27.3., jotta saatiin movies-niminen 
      // jäsenmuuttuja:
      List moviesJsonList = data["results"];

      // Tämä lisättiin 27.3.:
      return moviesJsonList.map((movieJson) => Movie.fromJson(movieJson)).toList();
  }
}
