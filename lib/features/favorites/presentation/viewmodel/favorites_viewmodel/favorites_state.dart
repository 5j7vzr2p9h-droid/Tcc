import '../../../../../core/errors/failures.dart';
import '../../../../root/domain/entities/item_entity.dart';

sealed class const FavoritesState();

final class const FavroitesInitialState() extends FavoritesState;

final class const FavoritesLoadingState() extends FavoritesState;

final class const FavoritesGetFailureState(
  final Failure failure
) extends FavoritesState;

final class const FavoritesGetSuccessState(
  final List<ItemEntity> favorites
) extends FavoritesState;