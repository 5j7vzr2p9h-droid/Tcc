import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/location_repository.dart';

final class GetDeviceLocationUsecase {
  final LocationRepository _repository;

  const GetDeviceLocationUsecase(this._repository);

  Future<Either<Failure, List<double>>> call()
  => _repository.getDeviceLocation();
}