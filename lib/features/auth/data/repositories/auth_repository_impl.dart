import 'package:dartz/dartz.dart';

import 'package:electronic_menu/core/errors/failures.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

final class AuthRepositoryImpl implements AuthRepository{
  final NetworkInfo _networkInfo;
  final AuthRemoteDatasource _remoteDatasource;

  const AuthRepositoryImpl({
    required this._networkInfo,
    required this._remoteDatasource
  });

  @override
  Future<Either<Failure, Unit>> login({required String phone}) async{
    if(await _networkInfo.isDeviceConnected)
      try{
        await _remoteDatasource.login(phone: phone);
        return const Right(unit);
      }on ServerException catch(e){
        return Left(ServerFailure(e.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }
    return const Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, String>> register({required String name, required String phone, required String address}) async{
    if(await _networkInfo.isDeviceConnected)
      try{
        final String successMessage = await _remoteDatasource.register(
          name: name,
          phone: phone,
          address: address
        );
        return Right(successMessage);
      }on ServerException catch(e){
        return Left(ServerFailure(e.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }
    return const Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, Unit>> verifyPhone({required String phone, required String code}) async{
    if(await _networkInfo.isDeviceConnected)
      try{
        await _remoteDatasource.verifyPhone(
          phone: phone,
          code: code
        );
        return const Right(unit);
      }on ServerException catch(e){
        return Left(ServerFailure(e.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }
    return const Left(UnknownFailure());
  }

  @override
  void logout() => _remoteDatasource.logout();
}