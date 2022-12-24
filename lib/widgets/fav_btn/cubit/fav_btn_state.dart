part of 'fav_btn_cubit.dart';

class LikeButtonState extends Equatable {
  final bool isLiked;
  const LikeButtonState(
    this.isLiked,
  );
  factory LikeButtonState.initial() => const LikeButtonState(false);

  LikeButtonState copyWith({
    bool? isLiked,
  }) {
    return LikeButtonState(
      isLiked ?? this.isLiked,
    );
  }

  @override
  List<Object?> get props => [isLiked];
}
