import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/item_entity.dart';
import '../repositories/items_repository.dart';

final class GetCategoryProductsUsecase {
  final ItemsRepository _repository;

  const new(this._repository);

  Future<Either<Failure, List<ItemEntity>>> call(int categoryId)
  => _repository.getCategoryProducts(categoryId);
}