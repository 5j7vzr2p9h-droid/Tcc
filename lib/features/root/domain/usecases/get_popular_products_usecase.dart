import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/item_entity.dart';
import '../repositories/items_repository.dart';

final class const GetPopularProductsUsecase(final ItemsRepository _repository) {

  Future<Either<Failure, List<ItemEntity>>> call()
  => _repository.getPopularProducts();
}