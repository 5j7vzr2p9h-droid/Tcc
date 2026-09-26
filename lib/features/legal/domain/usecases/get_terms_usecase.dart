import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/legal_list_entity.dart';
import '../repositories/legal_repository.dart';

final class const GetTermsUsecase(final LegalRepository _repository) {

  Future<Either<Failure, LegalListEntity>> call()
  => _repository.getTermsAndConditions();
}
