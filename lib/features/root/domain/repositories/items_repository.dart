import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/item_entity.dart';

abstract interface class ItemsRepository {
  Future<Either<Failure, List<ItemEntity>>> getCategoryProducts(int categoryId);
  Future<Either<Failure, List<ItemEntity>>> getPopularProducts();
  Future<Either<Failure, List<ItemEntity>>> searchProducts(String query);
}