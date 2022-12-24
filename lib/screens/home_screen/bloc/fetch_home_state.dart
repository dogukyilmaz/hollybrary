part of 'fetch_home_bloc.dart';

@immutable
abstract class FetchHomeState {}

class FetchHomeInitial extends FetchHomeState {}

class FetchHomeLoading extends FetchHomeState {}

class FetchHomeLoaded extends FetchHomeState {
  final List<MovieModel> trending;
  final List<MovieModel> topMovies;
  final List<SerieModel> tvShows;
  final List<SerieModel> topSeries;
  final List<MovieModel> upcoming;
  final List<MovieModel> popular;
  FetchHomeLoaded({
    required this.trending,
    required this.topMovies,
    required this.tvShows,
    required this.topSeries,
    required this.upcoming,
    required this.popular,
  });
}

class FetchHomeError extends FetchHomeState {
  final ErrorDataModel error;
  FetchHomeError({
    required this.error,
  });
}
