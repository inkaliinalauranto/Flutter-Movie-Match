import 'package:flutter/material.dart';
import 'package:flutter_app/providers/app_state.dart';
import 'package:flutter_app/widgets/card_stack_page.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.watch<MyAppState>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: FutureBuilder(
            future: appState.getPopularMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
        
              if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasError &&
                  snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(child: CardStackPage(movieList: snapshot.data!)),
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
                );
              }
        
              return Text("No movies at this time :(");
            }),
      ),
    );
  }
}
