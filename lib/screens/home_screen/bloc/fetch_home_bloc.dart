import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:hollybrary/api/home_data.dart';
import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/serie_model.dart';

part 'fetch_home_event.dart';
part 'fetch_home_state.dart';

class FetchHomeBloc extends Bloc<FetchHomeEvent, FetchHomeState> {
  final HomeDataRepo repo = HomeDataRepo();

  FetchHomeBloc() : super(FetchHomeInitial()) {
    on<FetchHomeEvent>((event, emit) async {
      if (event is FetchHomeData) {
        emit(FetchHomeLoading());
        try {
          final data = await repo.getHomePageMovies();
          emit(FetchHomeLoaded(
            topSeries: data[4],
            trending: data[0],
            tvShows: data[5],
            upcoming: data[3],
            popular: data[1],
            topMovies: data[2],
          ));
        } on ErrorDataModel catch (e) {
          emit(FetchHomeError(error: e));
        } catch (e) {
          emit(FetchHomeError(error: ErrorDataModel('something went wrong')));
        }
      }
    });
  }
}
