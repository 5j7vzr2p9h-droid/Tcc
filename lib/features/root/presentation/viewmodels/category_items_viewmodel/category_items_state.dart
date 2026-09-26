import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/item_entity.dart';

sealed class CategoryProductsState {
  const new();
}

final class CategoryProductsInitialState extends CategoryProductsState{
  const new();
}

final class CategoryProductsLoadingState extends CategoryProductsState{
  const new();
}

final class CategoryProductsGetSuccessState extends CategoryProductsState{
  final List<ItemEntity> products;

  const new(this.products);
}

final class CategoryProductsGetFailureState extends CategoryProductsState{
  final Failure failure;

  const new(this.failure);
}