import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hollybrary/api/cast_details.dart';
import 'package:hollybrary/models/cast_model.dart';
import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/serie_model.dart';

part 'castinfo_event.dart';
part 'castinfo_state.dart';

class CastinfoBloc extends Bloc<CastinfoEvent, CastinfoState> {
  final GetCastById repo = GetCastById();

  CastinfoBloc() : super(CastinfoInitial()) {
    on<CastinfoEvent>((event, emit) async {
      if (event is LoadCastInfo) {
        try {
          emit(CastinfoLoading());
          final data = await repo.getCastDetails(event.id);

          emit(CastinfoLoaded(
            info: data[0],
            movies: data[3],
            socialInfo: data[1],
            images: data[2],
            tvShows: data[4],
          ));
        } on ErrorDataModel catch (e) {
          emit(CastinfoError(error: e));
        } catch (e) {
          emit(CastinfoError(error: ErrorDataModel(e.toString())));
        }
      }
    });
  }
}
