import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/card_stack.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/movie_match_provider.dart';

class CardStackPage extends StatefulWidget {
  final List<Movie> movies;

  const CardStackPage({required this.movies, super.key});

  @override
  State<CardStackPage> createState() => _CardStackPageState();
}

class _CardStackPageState extends State<CardStackPage> {
  Map<String, String>? _lastParsedMatchMsg;

  @override
  Widget build(BuildContext context) {
    MovieMatchProvider movieMatchProvider = context.watch<MovieMatchProvider>();
    // Alla oleva ratkaisu showModalBottomSheetin reaaliaikaisesta 
    // näyttämisestä WidgetsBinding-luokkaa hyödyntämällä on saatu ChatGPT:ltä.
    // Varsinaisen showModalBottomSheet-ratkaisun lähde: 
    // https://www.youtube.com/watch?v=2hKSbiEcqoo
    Map<String, String> parsedMatchMsg = movieMatchProvider.parsedMatchMsg;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    if (_lastParsedMatchMsg != parsedMatchMsg && parsedMatchMsg.isNotEmpty) {
        _lastParsedMatchMsg = Map.from(parsedMatchMsg);
        movieMatchProvider.notifyModalBottomSheet({});

        // https://saw2110.medium.com/understanding-flutters-addpostframecallback-a-practical-guide-b3d3133b6b85
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You got a match with:",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          parsedMatchMsg.keys.first,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "The matched movie is:",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
                        child: Text(
                          "${parsedMatchMsg[parsedMatchMsg.keys.first]}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            shadowColor: colorScheme.shadow),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
    }

    if (widget.movies.isEmpty) {
      return Text("No movies available");
    }

    return CardStack(movieList: widget.movies);
  }
}
