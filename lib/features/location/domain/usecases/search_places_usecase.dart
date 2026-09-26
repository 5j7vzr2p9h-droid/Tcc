import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/suggested_place_entity.dart';
import '../repositories/location_repository.dart';

final class SearchPlacesUsecase {
  final LocationRepository _repository;

  const SearchPlacesUsecase(this._repository);

  Future<Either<Failure, List<SuggestedPlaceEntity>>> call(String query)
  => _repository.searchPlace(query);
}