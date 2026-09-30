import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/cache/prefs.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/uuid_generator/uuid_generator.dart';
import '../../domain/entities/checkout_entity.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../datasources/checkout_local_datasource.dart';
import '../datasources/checkout_remote_datasource.dart';
import '../models/checkout_model.dart';

final class const CheckoutRepositoryImpl({
  required final NetworkInfo _networkInfo,
  required final Prefs _prefs,
  required final UuidGenerator _uuidGenerator,
  required final CheckoutRemoteDatasource _remoteDatasource,
  required final CheckoutLocalDatasource _localDatasource
}) implements CheckoutRepository{
  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods() async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final List<PaymentMethodEntity> methods = await _remoteDatasource.getPaymentMethods();
        return Right(methods);
      } on ServerException catch(exception){
        return Left(ServerFailure(exception.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }catch(_){
        return const Left(UnknownFailure());
      }
    }else return const Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, Unit>> checkout(CheckoutEntity checkout) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final CheckoutModel model = CheckoutModel.fromEntity(
          checkout,
          branchId: _prefs.getInt(CacheKeys.branchId)!
        );
        final String body = jsonEncode(model.toJson());

        // Retrying the same order reuses its requestId, so if an earlier attempt reached the backend
        // but its response never reached us, the backend won't create the order twice.
        // Any change to the order (cart, address, payment method, ...) gets a new requestId.
        final String requestId = _localDatasource.getPendingRequestId(body) ?? _uuidGenerator.v4();
        await _localDatasource.savePendingRequest(requestId: requestId, body: body);

        await _remoteDatasource.checkout(requestId: requestId, checkout: model);
        await _localDatasource.clearPendingRequest();
        return const Right(unit);
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
