import 'package:flutter/material.dart';
import 'package:flutter_app/providers/movie_match_provider.dart';
import 'package:flutter_app/widgets/swipeable_cards.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

class CardStack extends StatelessWidget {
  const CardStack({
    super.key,
    required CardSwiperController controller,
    required this.widget,
  }) : _controller = controller;

  final CardSwiperController _controller;
  final SwipeableCards widget;

  @override
  Widget build(BuildContext context) {
    // Otettu pois Flexible-widgetin sisältä, jotta tämä saadaan palautettua 
    // palautettua Expanded-widgetistä, joka palautetaan Column-widgetistä. 
    // Ratkaisuun apua saatu ChatGPT:ltä.
    return CardSwiper(
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
    );
  }
}
