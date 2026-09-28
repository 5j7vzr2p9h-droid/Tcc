import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/item_entity.dart';
import '../repositories/items_repository.dart';

final class const SearchProductsUsecase(final ItemsRepository _repository) {

  Future<Either<Failure, List<ItemEntity>>> call(String query)
  => _repository.searchProducts(query);
}