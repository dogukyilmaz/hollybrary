import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hollybrary/api/movie_detail_by_id.dart';
import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';

part 'movie_info_event.dart';
part 'movie_info_state.dart';

class MovieInfoBloc extends Bloc<MovieInfoEvent, MovieInfoState> {
  final repo = GetMovieById();

  MovieInfoBloc() : super(MovieInfoInitial()) {
    on<MovieInfoEvent>((event, emit) async {
      if (event is LoadMoviesInfo) {
        try {
          emit(MovieInfoLoading());
          final List<dynamic> info = await repo.getDetails(event.id);
          emit(MovieInfoLoaded(
            imdbData: info[4],
            trailers: info[1],
            backdrops: info[2],
            tmdbData: info[0],
            cast: info[3],
            similar: info[5],
          ));
        } on ErrorDataModel catch (e) {
          emit(MovieInfoError(error: e));
        } catch (e) {
          emit(MovieInfoError(error: ErrorDataModel(e.toString())));
        }
      }
    });
  }
}
