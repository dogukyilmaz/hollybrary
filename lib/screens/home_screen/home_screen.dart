import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/fetch_home_bloc.dart';

import 'package:hollybrary/utils/app_animation.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/tv_model.dart';
import 'package:hollybrary/widgets/header_text.dart';
import 'package:hollybrary/widgets/horizontal_list_cards.dart';
import 'package:hollybrary/widgets/movie_home.dart';
import 'package:hollybrary/widgets/no_results_found.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchHomeBloc()..add(FetchHomeData()),
      child: BlocBuilder<FetchHomeBloc, FetchHomeState>(
        builder: (context, state) {
          if (state is FetchHomeLoaded) {
            return HomeScreenWidget(
              topRated: state.topRated,
              topShows: state.topShows,
              nowPlaying: state.nowPlaying,
              tvShows: state.topShows,
              tranding: state.tranding,
              upcoming: state.upcoming,
            );
          } else if (state is FetchHomeError) {
            return const ErrorPage();
          } else if (state is FetchHomeLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.grey.shade700,
                  strokeWidth: 2,
                  backgroundColor: Colors.cyanAccent,
                ),
              ),
            );
          }
          return const Scaffold();
        },
      ),
    );
  }
}

class HomeScreenWidget extends StatelessWidget {
  final List<MovieModel> tranding;
  final List<MovieModel> topRated;
  final List<TvModel> tvShows;
  final List<TvModel> topShows;
  final List<MovieModel> upcoming;
  final List<MovieModel> nowPlaying;
  const HomeScreenWidget({
    Key? key,
    required this.tranding,
    required this.topRated,
    required this.tvShows,
    required this.topShows,
    required this.upcoming,
    required this.nowPlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoviesPage(movies: tranding),
            const HeaderText(text: "Popular"),
            HorizontalListViewMovies(
              list: nowPlaying,
            ),
            const HeaderText(text: "Upcoming"),
            HorizontalListViewMovies(
              list: upcoming,
            ),
            const DelayedDisplay(
                delay: Duration(microseconds: 800),
                child: HeaderText(text: "Movies")),
            DelayedDisplay(
              delay: const Duration(microseconds: 800),
              child: HorizontalListViewMovies(
                list: tranding,
              ),
            ),
            const HeaderText(text: "Series"),
            HorizontalListViewTv(
              list: tvShows,
            ),
            const HeaderText(text: "Top Movies"),
            HorizontalListViewMovies(
              list: topRated,
            ),
            const HeaderText(text: "Top Series"),
            HorizontalListViewTv(
              list: topShows,
            ),
          ],
        ),
      ),
    );
  }
}
