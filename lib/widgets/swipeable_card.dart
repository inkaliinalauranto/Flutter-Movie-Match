import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/moviematch.dart';

class SwipeableCards extends StatefulWidget {
  final List<Movie> movies;

  const SwipeableCards(this.movies, {super.key});

  @override
  State<SwipeableCards> createState() => _SwipeableCardsState();
}

class _SwipeableCardsState extends State<SwipeableCards> {
  Map<String, String>? _lastMatch;
  final CardSwiperController _controller = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    // Alla oleva ratkaisu showModalBottomSheetin on saatu ChatGPT:ltä. Merkkaa showModalBottomSheet-ratkaisun lähteet.
    var match = context.select<MovieMatchProvider, Map<String, String>>(
        (provider) => provider.match);

    if (_lastMatch != match && match.isNotEmpty) {
      List<String> parts = match["user"]!.split("|");

      String otherUser = "";

      for (String user in parts) {
        if (user != context.watch<MovieMatchProvider>().userName) {
          otherUser = user;
          break;
        }
      }

      if (otherUser != context.watch<MovieMatchProvider>().userName) {
        _lastMatch = Map.from(match);
        print(
            "///////////////////////////////////////// Marchin username ${otherUser} Oma username ${context.watch<MovieMatchProvider>().userName}");

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
                          "${otherUser}",
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
                          "${match['data']}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shadowColor: Theme.of(context).colorScheme.shadow),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
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

    return Flexible(
      child: CardSwiper(
        controller: _controller,
        cardBuilder: (context, index, thresholdX, thresholdY) {
          final movie = widget.movies[index];
          final fullImageUrl =
              "https://image.tmdb.org/t/p/w500${movie.posterPath}";
          return Center(child: Image.network(fullImageUrl));
        },
        cardsCount: widget.movies.length,
        onSwipe: (oldIndex, newIndex, direction) {
          if (direction == CardSwiperDirection.right) {
            final movieTitle = widget.movies[oldIndex].originalTitle;
            context.read<MovieMatchProvider>().send(movieTitle);
          }

          return true;
        },
        isLoop: false,
        allowedSwipeDirection: AllowedSwipeDirection.only(
          left: true,
          right: true,
        ),
      ),
    );
  }
}
