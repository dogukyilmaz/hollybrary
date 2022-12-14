part of 'castinfo_bloc.dart';

abstract class CastinfoState extends Equatable {
  const CastinfoState();

  @override
  List<Object> get props => [];
}

class CastinfoInitial extends CastinfoState {}

class CastinfoLoaded extends CastinfoState {
  final CastModel info;
  final SocialMediaInfo socialInfo;
  final List<SerieModel> tvShows;
  final List<ImageBackdrop> images;
  final List<MovieModel> movies;
  const CastinfoLoaded({
    required this.info,
    required this.socialInfo,
    required this.tvShows,
    required this.images,
    required this.movies,
  });
}

class CastinfoLoading extends CastinfoState {}

class CastinfoError extends CastinfoState {
  final ErrorDataModel error;
  const CastinfoError({
    required this.error,
  });
}
