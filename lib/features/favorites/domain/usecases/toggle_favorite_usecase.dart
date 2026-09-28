import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/favorites_repository.dart';

final class const ToggleFavoriteUsecase(
  final FavoritesRepository _repository
){

  Future<Either<Failure, Unit>> call(
    int id,
    bool newValue
  )
  => _repository.toggleFavorite(id, newValue);
}