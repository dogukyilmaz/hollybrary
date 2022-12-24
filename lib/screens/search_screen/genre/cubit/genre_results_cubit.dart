import 'package:bloc/bloc.dart';

import 'package:hollybrary/api/genre_detail.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/serie_model.dart';

part 'genre_results_state.dart';

class GenreResultsCubit extends Cubit<GenreResultsState> {
  GenreResultsCubit() : super(GenreResultsState.initial());
  final repo = GenreDataRepo();
  void init(String query) async {
    try {
      emit(state.copyWith(movieStatus: MovieStatus.loading, query: query));
      final movies = await repo.getmovies(query, state.moviePage);
      emit(
        state.copyWith(
          movieStatus: MovieStatus.loaded,
          movies: movies[0],
          moviePage: state.moviePage + 1,
        ),
      );
    } catch (e) {
      emit(state.copyWith(movieStatus: MovieStatus.error));
    }
  }

  void loadNextMoviePage() async {
    if (!state.moviesFull) {
      emit(state.copyWith(movieStatus: MovieStatus.adding));
      final movies = await repo.getmovies(state.query, state.moviePage);
      state.movies.addAll(movies[0]);
      emit(
        state.copyWith(
          movies: state.movies,
          moviePage: state.moviePage + 1,
          moviesFull: movies[1] != state.moviePage,
        ),
      );
    } else {
      emit(state.copyWith(movieStatus: MovieStatus.allfetched));
    }
  }

  void loadNextTvPage() async {
    if (!state.tvFull) {
      emit(state.copyWith(tvStatus: TvStatus.adding));
      final shows = await repo.getSeries(state.query, state.tvPage);
      state.shows.addAll(shows[0]);
      emit(
        state.copyWith(
          shows: state.shows,
          tvPage: state.tvPage + 1,
          tvFull: shows[1] != state.tvPage,
        ),
      );
    } else {
      emit(state.copyWith(tvStatus: TvStatus.allfetched));
    }
  }

  void initTv(String query) async {
    try {
      emit(state.copyWith(tvStatus: TvStatus.loading));
      final shows = await repo.getSeries(query, state.tvPage);
      emit(
        state.copyWith(
          tvStatus: TvStatus.loaded,
          shows: shows[0],
          tvPage: state.tvPage + 1,
        ),
      );
    } catch (e) {
      // print(e.toString());
      emit(state.copyWith(tvStatus: TvStatus.error));
    }
  }
}
