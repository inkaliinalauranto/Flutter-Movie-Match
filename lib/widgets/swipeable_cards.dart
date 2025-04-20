import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/card_stack.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/movie_match_provider.dart';

class SwipeableCards extends StatefulWidget {
  final List<Movie> movies;

  const SwipeableCards(this.movies, {super.key});

  @override
  State<SwipeableCards> createState() => _SwipeableCardsState();
}

class _SwipeableCardsState extends State<SwipeableCards> {
  Map<String, String>? _lastMatchMessage;
  final CardSwiperController _controller = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    MovieMatchProvider movieMatchProvider = context.watch<MovieMatchProvider>();
    // Alla oleva ratkaisu showModalBottomSheetin on saatu ChatGPT:ltä.
    // showModalBottomSheet-ratkaisun lähteet: https://www.youtube.com/watch?v=2hKSbiEcqoo
    Map<String, String> matchMessage = movieMatchProvider.match;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    if (_lastMatchMessage != matchMessage && matchMessage.isNotEmpty) {
      List<String> userMessageParts = matchMessage["user"]!.split("|");

      String? otherUser;

      for (String user in userMessageParts) {
        if (user != movieMatchProvider.userName) {
          otherUser = user;
          break;
        }
      }

      if (otherUser != null && otherUser != movieMatchProvider.userName) {
        _lastMatchMessage = Map.from(matchMessage);
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
                          otherUser!,
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
                          "${_lastMatchMessage!['data']}",
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
    }

    if (widget.movies.isEmpty) {
      return Text("No movies available");
    }

    return CardStack(controller: _controller, widget: widget);
  }
}
