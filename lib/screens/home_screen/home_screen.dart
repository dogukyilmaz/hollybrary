import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/fetch_home_bloc.dart';

import 'package:hollybrary/utils/app_animation.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/serie_model.dart';
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
              topMovies: state.topMovies,
              topSeries: state.topSeries,
              popular: state.popular,
              tvShows: state.topSeries,
              trending: state.trending,
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
                  backgroundColor: Colors.purpleAccent.shade200,
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
  final List<MovieModel> trending;
  final List<MovieModel> topMovies;
  final List<SerieModel> tvShows;
  final List<SerieModel> topSeries;
  final List<MovieModel> upcoming;
  final List<MovieModel> popular;
  const HomeScreenWidget({
    Key? key,
    required this.trending,
    required this.topMovies,
    required this.tvShows,
    required this.topSeries,
    required this.upcoming,
    required this.popular,
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
            MoviesPage(movies: trending),
            const HeaderText(text: "Popular"),
            HorizontalListViewMovies(
              list: popular,
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
                list: trending,
              ),
            ),
            const HeaderText(text: "Series"),
            HorizontalListViewTv(
              list: tvShows,
            ),
            const HeaderText(text: "Top Movies"),
            HorizontalListViewMovies(
              list: topMovies,
            ),
            const HeaderText(text: "Top Series"),
            HorizontalListViewTv(
              list: topSeries,
            ),
          ],
        ),
      ),
    );
  }
}
