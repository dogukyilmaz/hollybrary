import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hollybrary/api/fetch_season_info.dart';
import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/season_details_model.dart';

part 'season_detail_event.dart';
part 'season_detail_state.dart';

class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  final repo = FetchSeasonInfo();

  SeasonDetailBloc() : super(SeasonDetailInitial()) {
    on<SeasonDetailEvent>((event, emit) async {
      if (event is LoadSeasonInfo) {
        try {
          emit(SeasonDetailLoading());

          final data = await repo.getSeasonDetail(event.id, event.snum);
          emit(SeasonDetailLoaded(
            cast: data[1],
            seasonDetail: data[0],
            trailers: data[2],
            backdrops: data[3],
          ));
        } on FetchDataError catch (e) {
          emit(SeasonDetailError(error: e));
        } catch (e) {
          emit(SeasonDetailError(
              error: FetchDataError("Something wents wrong!")));
        }
      }
    });
  }
}
