import 'package:flutter/material.dart';
import 'package:flutter_app/providers/movie_match_provider.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MovieMatchProvider movieMatchState = context.watch<MovieMatchProvider>();
    final theme = Theme.of(context);

    if (movieMatchState.matchList.isEmpty) {
      return Center(
        child: Text('No matches yet.'),
      );
    }

    // Oma lisäys, lähde Youtube-videosta: https://www.youtube.com/watch?v=yXnTBLSRd_o
    return ListView(padding: EdgeInsets.symmetric(horizontal: 10), children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
        child: Text("Movie Matches",
            style: TextStyle(
                fontSize: 32,
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold)),
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          var movies = movieMatchState.matchList[index]["data"];
          return Card(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                child: Text(
                  "Matches with ${movieMatchState.matchList[index]["user"]}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              for (var mov in movies)
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text(mov),
                )
            ]),
          );
        },
        itemCount: movieMatchState.matchList.length,
        padding: EdgeInsets.all(4),
      ),
    ]);
  }
}
