import 'package:flutter/material.dart';

import 'package:hollybrary/utils/app_animation.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/serie_model.dart';
import 'package:hollybrary/screens/movie_info_screen/movie_Info_screen.dart';
import 'package:hollybrary/screens/tvshow_info_screen/tvshow_info_screen.dart';
import 'movie_card.dart';

class HorizontalListViewMovies extends StatelessWidget {
  final List<MovieModel> list;
  final Color? color;
  const HorizontalListViewMovies({
    Key? key,
    required this.list,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 280,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 10),
            for (var i = 0; i < list.length; i++)
              MovieCard(
                isMovie: true,
                id: list[i].id,
                name: list[i].title,
                backdrop: list[i].backdrop,
                poster: list[i].poster,
                color: color == null ? Colors.white : color!,
                date: list[i].releaseDate,
                onTap: () {
                  pushNewScreen(
                    context,
                    MovieDetailsScreen(
                      id: list[i].id,
                      backdrop: list[i].backdrop,
                    ),
                  );
                },
              )
          ],
        ));
  }
}

class HorizontalListViewTv extends StatelessWidget {
  final List<SerieModel> list;
  final Color? color;

  const HorizontalListViewTv({
    Key? key,
    required this.list,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 280,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 10),
            for (var i = 0; i < list.length; i++)
              MovieCard(
                isMovie: true,
                id: list[i].id,
                name: list[i].title,
                backdrop: list[i].backdrop,
                poster: list[i].poster,
                color: color == null ? Colors.white : color!,
                date: list[i].releaseDate,
                onTap: () {
                  pushNewScreen(
                    context,
                    TvShowDetailScreen(
                      backdrop: list[i].backdrop,
                      id: list[i].id,
                    ),
                  );
                },
              )
          ],
        ));
  }
}
