import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../root/domain/entities/item_entity.dart';
import '../repositories/favorites_repository.dart';

final class const GetFavoritesUsecase(
  final FavoritesRepository _repository
){

  Future<Either<Failure, List<ItemEntity>>> call()
  => _repository.getFavorites();
}