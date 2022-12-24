import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hollybrary/api/serie_detail.dart';
import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/serie_model.dart';

part 'tv_show_detail_event.dart';
part 'tv_show_detail_state.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  final GetSerieDetail repo = GetSerieDetail();

  TvShowDetailBloc() : super(TvShowDetailInitial()) {
    on<TvShowDetailEvent>((event, emit) async {
      if (event is LoadTvInfo) {
        try {
          emit(TvShowDetailLoading());
          final data = await repo.getTvDetails(event.id);
          emit(TvShowDetailLoaded(
            backdrops: data[2],
            cast: data[3],
            similar: data[4],
            tmdbData: data[0],
            trailers: data[1],
          ));
        } on ErrorDataModel catch (e) {
          emit(TvShowDetailError(error: e));
        } catch (e) {
          emit(TvShowDetailError(error: ErrorDataModel(e.toString())));
        }
      }
    });
  }
}
