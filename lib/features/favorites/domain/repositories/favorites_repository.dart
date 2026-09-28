import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../root/domain/entities/item_entity.dart';

abstract interface class const FavoritesRepository() {

  Future<Either<Failure, List<ItemEntity>>> getFavorites();
  Future<Either<Failure, Unit>> toggleFavorite(int id, bool newValue);
}