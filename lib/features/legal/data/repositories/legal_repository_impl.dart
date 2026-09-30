import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/legal_list_entity.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/legal_repository.dart';
import '../datasources/legal_remote_datasource.dart';

final class LegalRepositoryImpl implements LegalRepository{
  final NetworkInfo _networkInfo;
  final LegalRemoteDatasource _remoteDatasource;

  const LegalRepositoryImpl({
    required this._networkInfo,
    required this._remoteDatasource
  });

  @override
  Future<Either<Failure, LegalListEntity>> getPrivacyPolicy()
  => _getLegalList(isPrivacyPolicy: true);

  @override
  Future<Either<Failure, LegalListEntity>> getTermsAndConditions()
  => _getLegalList(isPrivacyPolicy: false);


  Future<Either<Failure, LegalListEntity>> _getLegalList({required bool isPrivacyPolicy})async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final LegalListEntity legalList = isPrivacyPolicy
          ? await _remoteDatasource.getPrivacyPolicy()
          : await _remoteDatasource.getTermsAndConditions();
        return Right(legalList);
      }on ServerException catch(e){
        return Left(ServerFailure(e.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }catch(_){
        return const Left(UnknownFailure());
      }
    }
    else return const Left(OfflineFailure());
  }
}
