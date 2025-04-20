import 'package:flutter/material.dart';
import 'package:flutter_app/views/my_home_page.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationRail extends StatelessWidget {
  const CustomNavigationRail({
    super.key,
    required this.widget,
  });

  final MyHomePage widget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: constraints.maxWidth >= 600,
              destinations: [
                NavigationRailDestination(
                    icon: GestureDetector(
                      child: Icon(Icons.person),
                      onTap: () => {context.go("/")},
                    ),
                    label: Text("Identify")),
                NavigationRailDestination(
                  icon: GestureDetector(
                    child: Icon(Icons.movie_outlined),
                    onTap: () => {context.go("/movies")},
                  ),
                  label: Text('Movies'),
                ),
                NavigationRailDestination(
                  icon: GestureDetector(
                    child: Icon(Icons.favorite_border),
                    onTap: () => {context.go("/favorites")},
                  ),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: null,
              // onDestinationSelected: (value) {
              //   setState(() {
              //     selectedIndex = value;
              //   });
              // },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: widget.child,
            ),
          ),
        ],
      );
    });
  }
}
