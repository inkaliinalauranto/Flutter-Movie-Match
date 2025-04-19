import 'package:flutter/material.dart';
import 'package:flutter_app/providers/app_state.dart';
import 'package:flutter_app/providers/moviematch.dart';
import 'package:flutter_app/widgets/swipeable_card.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 18.4.2025, piti muuttaa readista watchiksi:
    // var movieMatch = context.watch<MovieMatchProvider>();
    var appState = context.watch<MyAppState>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: appState.getPopularMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.connectionState == ConnectionState.done &&
                      !snapshot.hasError &&
                      snapshot.hasData) {
                    return SwipeableCards(snapshot.data!);
                  }

                  return Text("No movies at this time :(");
                }),
            // https://apps.timwhitlock.info/emoji/tables/unicode
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Swipe left \u{1F448} if pass or right \u{1F449} if you like",
                  style: TextStyle(fontStyle: FontStyle.italic),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
