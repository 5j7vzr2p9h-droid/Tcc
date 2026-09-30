import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_remote_datasource.dart';

final class const WalletRepositoryImpl({
  required final NetworkInfo _networkInfo,
  required final WalletRemoteDatasource _remoteDatasource
}) implements WalletRepository{
  @override
  Future<Either<Failure, double>> getBalance() async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final double balance = await _remoteDatasource.getBalance();
        return Right(balance);
      } on ServerException catch(exception){
        return Left(ServerFailure(exception.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }catch(_){
        return const Left(UnknownFailure());
      }
    }else return const Left(OfflineFailure());
  }
}
