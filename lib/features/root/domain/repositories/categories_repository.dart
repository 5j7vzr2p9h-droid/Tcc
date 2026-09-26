import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/category_entity.dart';

abstract interface class CategoriesRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}