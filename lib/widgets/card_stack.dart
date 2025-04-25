import 'package:flutter/material.dart';
import 'package:flutter_app/models/movie.dart';
import 'package:flutter_app/providers/movie_match_provider.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

class CardStack extends StatefulWidget {
  const CardStack({
    super.key,
    required this.movieList,
  });

  final List<Movie> movieList;

  @override
  State<CardStack> createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {
  final CardSwiperController _controller = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    MovieMatchProvider movieMatchProviderR = context.read<MovieMatchProvider>();
    // Otettu pois Flexible-widgetin sisältä, jotta tämä saadaan palautettua 
    // palautettua Expanded-widgetistä, joka palautetaan Column-widgetistä. 
    // Ratkaisuun apua saatu ChatGPT:ltä.
    return CardSwiper(
      controller: _controller,
      cardBuilder: (context, index, thresholdX, thresholdY) {
        final movie = widget.movieList[index];
        final fullImageUrl =
            "https://image.tmdb.org/t/p/w500${movie.posterPath}";
        return Center(child: Image.network(fullImageUrl));
      },
      cardsCount: widget.movieList.length,
      onSwipe: (oldIndex, newIndex, direction) {
        if (direction == CardSwiperDirection.right) {
          final movieTitle = widget.movieList[oldIndex].originalTitle;
          movieMatchProviderR.send(movieTitle);
        }
    
        return true;
      },
      isLoop: true,
      allowedSwipeDirection: AllowedSwipeDirection.only(
        left: true,
        right: true,
      ),
    );
  }
}
