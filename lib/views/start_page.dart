import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/moviematch.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var movieMatch = context.watch<MovieMatchProvider>();

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text("Your current username:", style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 50),
            child: Text(movieMatch.userName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          TextFormField(controller: controller, decoration: const InputDecoration(hintText: "Enter a new username if desired"),),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: ElevatedButton(
              onPressed: () {
                if (controller.text == "") {
                  movieMatch.setUserName(WordPair.random().join());
                } else {
                  movieMatch.setUserName(controller.text);
                }
              },
              child: Text("Change"),
            ),
          )
        ],
      ),
    );
  }
}
