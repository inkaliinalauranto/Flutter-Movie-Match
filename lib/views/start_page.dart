import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/movie_match_provider.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final TextEditingController controller = TextEditingController();
  bool isDisabled = true;

  void setIsEnabled() {
    setState(() {
      if (controller.text.trim().isEmpty) {
        isDisabled = true;
      } else {
        isDisabled = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(setIsEnabled);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MovieMatchProvider movieMatch = context.watch<MovieMatchProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Padding(
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
              child: Text(movieMatch.getUsername(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            TextFormField(controller: controller, decoration: const InputDecoration(hintText: "Enter a new username if desired"),),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: isDisabled ? null : () {
                  if (controller.text == "") {
                    movieMatch.setUsername(WordPair.random().join());
                  } else {
                    movieMatch.setUsername(controller.text);
                    controller.text = "";
                  }
                },
                child: Text("Change"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
