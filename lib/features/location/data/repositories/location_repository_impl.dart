import 'package:dartz/dartz.dart';

import '../../../../core/cache/prefs.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/location/location_service.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/branch_entity.dart';
import '../../domain/entities/suggested_place_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/places_remote_datasource.dart';

final class LocationRepositoryImpl implements LocationRepository{
  final Prefs _prefs;
  final LocationService _locationService;
  final PlacesRemoteDatasource _placesRemoteDatasource;
  final NetworkInfo _networkInfo;

  const LocationRepositoryImpl({
    required this._prefs,
    required this._locationService,
    required this._placesRemoteDatasource,
    required this._networkInfo
  });

  @override
  Future<Either<Failure, List<double>>> getDeviceLocation() async{
    try{
      final List<double> coordinates = await _locationService.getMyLocationCoordinates();
      return Right(coordinates);
    }on PermissionAccessDeniedException{
      return const Left(PermissionAccessDeniedFailure());
    }on LocationDisabledException{
      return const Left(LocationDisabledFailure());
    }on LocationTimeOutException{
      return const Left(LocationTimeOutFailure());
    }on LocationUnknownException{
      return const Left(LocationUnknownFailure());
    }
  }

  @override
  Future<String?> getAddressName(List<double> coordinates)
  => _locationService.getAddressName(coordinates[0], coordinates[1]);

  @override
  Future<Either<Failure, List<SuggestedPlaceEntity>>> searchPlace(String query) async{
    try {
      return await (await getDeviceLocation()).fold(
        (Failure failure) => Left(failure),
        (List<double> coordinates) async{
          if(await _networkInfo.isDeviceConnected){
            final List<SuggestedPlaceEntity> models = await _placesRemoteDatasource.searchPlace(
              query: query,
              lat: coordinates[0],
              lng: coordinates[1],
            );
            return Right(models);
          } else return const Left(OfflineFailure());
        }
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on OfflineException {
      return const Left(OfflineFailure());
    } on UnknownException {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<double>>> getPlaceCoordinates(String placeId) async{
    if(await _networkInfo.isDeviceConnected)
      try {
        final List<double> coordinates = await _placesRemoteDatasource.getPlaceCoordinates(placeId);
        return Right(coordinates);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on OfflineException {
        return const Left(OfflineFailure());
      } on UnknownException {
        return const Left(UnknownFailure());
      }
    else return const Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, BranchEntity>> getBranch() async{
    try {
      return await (await getDeviceLocation()).fold(
        (Failure failure) => Left(failure),
        (List<double> coordinates) async {
          if (await _networkInfo.isDeviceConnected) {
            final BranchEntity branch = await _placesRemoteDatasource.getBranch(
              // TODO: Remove this and return coordinates[0, 1]
              lat: 30.978812,
              lng: 31.199294
              // lat: coordinates[0],
              // lng: coordinates[1],
            );

            _prefs.setInt(
              key: CacheKeys.branchId,
              value: branch.id,
            );
            return Right(branch);
          } else {
            return const Left(OfflineFailure());
          }
        },
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on OfflineException {
      return const Left(OfflineFailure());
    } on UnknownException {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addAddress({
    required String addressText,
    required bool isDefault,
    required double lat,
    required double lng
  }) async{
    if(await _networkInfo.isDeviceConnected)
      try {
        await _placesRemoteDatasource.addAddress(
          addressText: addressText,
          isDefault: isDefault,
          lat: lat,
          lng: lng
        );
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on OfflineException {
        return const Left(OfflineFailure());
      } catch(_) {
        return const Left(UnknownFailure());
      }
    return const Left(OfflineFailure());
  }
}