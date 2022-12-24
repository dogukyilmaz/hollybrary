part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailState extends Equatable {
  const TvShowDetailState();

  @override
  List<Object> get props => [];
}

class TvShowDetailInitial extends TvShowDetailState {}

class TvShowDetailLoaded extends TvShowDetailState {
  final SerieDetailModel tmdbData;
  final List<SerieModel> similar;
  final List<CastInfo> cast;
  final List<ImageBackdrop> backdrops;
  final List<TrailerModel> trailers;

  const TvShowDetailLoaded({
    required this.tmdbData,
    required this.similar,
    required this.cast,
    required this.backdrops,
    required this.trailers,
  });
}

class TvShowDetailLoading extends TvShowDetailState {}

class TvShowDetailError extends TvShowDetailState {
  final ErrorDataModel error;
  const TvShowDetailError({
    required this.error,
  });
}
