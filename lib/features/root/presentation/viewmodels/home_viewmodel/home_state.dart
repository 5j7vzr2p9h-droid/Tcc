import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/category_entity.dart';

sealed class HomeState {
  const new();
}

final class HomeInitialState extends HomeState{
  const new();
}

final class HomeLoadingState extends HomeState{
  const new();
}

final class HomeGetSuccessState extends HomeState{
  final List<CategoryEntity> categories;

  const new({
    required this.categories
  });
}

final class HomeGetFailureState extends HomeState{
  final Failure failure;

  const new(this.failure);
}