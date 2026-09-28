import 'package:dartz/dartz.dart';

import 'package:electronic_menu/core/errors/failures.dart';

import 'package:electronic_menu/features/orders/data/models/order_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_remote_datasource.dart';

final class const OrdersRepositoryImpl({
  required final NetworkInfo _networkInfo,
  required final OrdersRemoteDatasource _remoteDatasource
}) implements OrdersRepository{
  @override
  Future<Either<Failure, List<OrderModel>>> getCurrentOrders() async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final List<OrderModel> orders = await _remoteDatasource.getCurrentOrders();
        return Right(orders);
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
  Future<Either<Failure, List<OrderModel>>> getPreviousOrders() async {
    if(await _networkInfo.isDeviceConnected){
      try{
        final List<OrderModel> orders = await _remoteDatasource.getPreviousOrders();
        return Right(orders);
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