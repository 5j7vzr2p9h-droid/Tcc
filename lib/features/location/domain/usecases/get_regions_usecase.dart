import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/region_model.dart';
import '../repositories/location_repository.dart';

final class const GetRegionsUsecase(final LocationRepository _repository) {

  Future<Either<Failure, List<RegionModel>>> call()
  => _repository.getRegions();
}