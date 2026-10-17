import 'package:dartz/dartz.dart';

import 'package:electronic_menu/core/errors/failures.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/banners_repository.dart';
import '../datasources/banners_remote_datasource.dart';

final class BannersRepositoryImpl({
  required final NetworkInfo _networkInfo,
  required final BannersRemoteDatasource _remoteDatasource
}) implements BannersRepository{

  @override
  Future<Either<Failure, List<String>>> getBanners() async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final List<String> banners = await _remoteDatasource.getBanners();
        return Right(banners);
      }on OfflineException{
        return const Left(OfflineFailure());
      }on ServerException catch(e){
        return Left(ServerFailure(e.message));
      }catch(_){
        return const Left(UnknownFailure());
      }
    }
    return const Left(OfflineFailure());
  }
}