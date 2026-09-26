import 'package:dartz/dartz.dart';
import 'package:electronic_menu/features/delivery/domain/entities/suggested_place_entity.dart';
import 'package:electronic_menu/features/location/domain/entities/branch_entity.dart';

import '../../../../core/cache/prefs.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/location/location_service.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/places_remote_datasource.dart';

final class LocationRepositoryImpl implements LocationRepository{
  final Prefs _prefs;
  final LocationService _locationService;
  final PlacesRemoteDatasource _placesRemoteDatasource;

  const LocationRepositoryImpl({
    required this._prefs,
    required this._locationService,
    required this._placesRemoteDatasource
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
          final List<SuggestedPlaceEntity> models = await _placesRemoteDatasource.searchPlace(
            query: query,
            lat: coordinates[0],
            lng: coordinates[1],
          );
          return Right(models);
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
  }

  @override
  Future<Either<Failure, BranchEntity>> getBranch({required double lat, required double lng}) async{
    try {
      final BranchEntity branch = await _placesRemoteDatasource.getBranch(lat: lat, lng: lng);
      _prefs.setInt(key: CacheKeys.branchId, value: branch.id);
      return Right(branch);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on OfflineException {
      return const Left(OfflineFailure());
    } on UnknownException {
      return const Left(UnknownFailure());
    }
  }
}