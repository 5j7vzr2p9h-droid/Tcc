import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/location_repository.dart';

final class GetPlaceCoordinatesUsecase {
  final LocationRepository _repository;

  const GetPlaceCoordinatesUsecase(this._repository);

  Future<Either<Failure, List<double>>> call(String placeId)
  => _repository.getPlaceCoordinates(placeId);
}
