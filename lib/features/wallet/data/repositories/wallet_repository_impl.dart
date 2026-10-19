import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/network_info.dart';
import '../../../../core/uuid_generator/uuid_generator.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_remote_datasource.dart';
import '../models/wallet_transaction_model.dart';

final class const WalletRepositoryImpl({
  required final UuidGenerator _uuidGenerator,
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
    } else return const Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, Unit>> topupThroughInstapay(String instapayUsername) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final String requestId = _uuidGenerator.v4();
        await _remoteDatasource.topupThroughInstapay(
          instapayUsername: instapayUsername,
          requestId: requestId
        );
        return const Right(unit);
      } on ServerException catch(exception){
        return Left(ServerFailure(exception.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }catch(_){
        return const Left(UnknownFailure());
      }
    } else return const Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, Unit>> topupThroughVodafone(String senderMobile) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final String requestId = _uuidGenerator.v4();
        await _remoteDatasource.topupThroughVodafone(
          senderMobile: senderMobile,
          requestId: requestId
        );
        return const Right(unit);
      } on ServerException catch(exception){
        return Left(ServerFailure(exception.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }catch(_){
        return const Left(UnknownFailure());
      }
    } else return const Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, List<WalletTransactionModel>>> getWalletTransactions() async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final List<WalletTransactionModel> walletTransactions = await _remoteDatasource.getWalletTransactions();
        return Right(walletTransactions);
      } on ServerException catch(exception){
        return Left(ServerFailure(exception.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }catch(_){
        return const Left(UnknownFailure());
      }
    } else return const Left(OfflineFailure());
  }
}
