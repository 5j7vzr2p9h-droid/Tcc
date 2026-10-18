import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/branch_entity.dart';
import '../repositories/location_repository.dart';

final class const GetBranchUsecase(
  final LocationRepository _repository
){

  Future<Either<Failure, BranchEntity>> call ()
  => _repository.getBranch();
}