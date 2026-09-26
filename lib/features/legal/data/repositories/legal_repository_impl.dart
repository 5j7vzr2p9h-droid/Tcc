import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/legal_list_entity.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/legal_repository.dart';
import '../datasources/legal_local_datasource.dart';
import '../datasources/legal_remote_datasource.dart';
import '../models/legal_list_model.dart';

final class LegalRepositoryImpl implements LegalRepository{
  final NetworkInfo _networkInfo;
  final LegalRemoteDatasource _remoteDatasource;
  final LegalLocalDatasource _localDatasource;

  const LegalRepositoryImpl({
    required this._networkInfo,
    required this._remoteDatasource,
    required this._localDatasource
  });

  @override
  Future<Either<Failure, LegalListEntity>> getPrivacyPolicy()
  => _getLegalList(isPrivacyPolicy: true);

  @override
  Future<Either<Failure, LegalListEntity>> getTermsAndConditions()
  => _getLegalList(isPrivacyPolicy: false);


  Future<Either<Failure, LegalListEntity>> _getLegalList({required bool isPrivacyPolicy})async{
    try{
      final LegalListEntity legalList = isPrivacyPolicy
        ? _localDatasource.getCachedPrivacyPolicy()
        : _localDatasource.getCachedTermsAndConditions();
      return Right(legalList);
    }catch(e){
      if(await _networkInfo.isDeviceConnected){
        try{
          final LegalListModel legalList;
          if(isPrivacyPolicy){
            legalList = await _remoteDatasource.getPrivacyPolicy();
            _localDatasource.cachePrivacyPolicy(legalList);
          }else{
            legalList = await _remoteDatasource.getTermsAndConditions();
            _localDatasource.cacheTermsAndConditions(legalList);
          }
          return Right(legalList);
        }on ServerException catch(e){
          return Left(ServerFailure(e.message));
        }on OfflineException{
          return const Left(OfflineFailure());
        }on UnknownException{
          return const Left(UnknownFailure());
        }
      }
    }
    return const Left(OfflineFailure());
  }
}
