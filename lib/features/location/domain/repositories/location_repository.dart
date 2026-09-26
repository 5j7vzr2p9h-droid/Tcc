import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../delivery/domain/entities/suggested_place_entity.dart';
import '../entities/branch_entity.dart';

abstract interface class LocationRepository {
  Future<Either<Failure, List<double>>> getDeviceLocation();
  Future<String?> getAddressName(List<double> coordinates);

  Future<Either<Failure, List<SuggestedPlaceEntity>>> searchPlace(String query);
  Future<Either<Failure, List<double>>> getPlaceCoordinates(String placeId);
  
  Future<Either<Failure, BranchEntity>> getBranch({
    required double lat,
    required double lng
  });
}