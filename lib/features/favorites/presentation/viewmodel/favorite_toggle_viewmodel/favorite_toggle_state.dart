import '../../../../../core/errors/failures.dart';

sealed class const FavoriteToggleState(
  final bool isFavorite
);

final class const FavoriteToggleIdleState(super.isFavorite) extends FavoriteToggleState;

final class const FavoriteToggleLoadingState(super.isFavorite) extends FavoriteToggleState;

final class const FavoriteToggleSuccessState(super.isFavorite) extends FavoriteToggleState;

final class const FavoriteToggleFailureState(
  super.isFavorite,
  final Failure failure
) extends FavoriteToggleState;
