import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hollybrary/api/fetch_tv_show_info.dart';
import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/tv_model.dart';

part 'tv_show_detail_event.dart';
part 'tv_show_detail_state.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  final FetchTvShowDetail repo = FetchTvShowDetail();

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
        } on FetchDataError catch (e) {
          emit(TvShowDetailError(error: e));
        } catch (e) {
          emit(TvShowDetailError(error: FetchDataError(e.toString())));
        }
      }
    });
  }
}
