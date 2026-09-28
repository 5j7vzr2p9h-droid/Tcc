import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/item_entity.dart';

sealed class HomeState {
  const new();
}

final class HomeInitialState extends HomeState{
  const new();
}

final class HomeLoadingState extends HomeState{
  const new();
}

final class const HomeGetSuccessState({
  required final List<CategoryEntity> categories,
  required final List<ItemEntity> popularItems
}) extends HomeState;

final class HomeGetFailureState extends HomeState{
  final Failure failure;

  const new(this.failure);
}