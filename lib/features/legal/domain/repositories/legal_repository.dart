import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/legal_list_entity.dart';

abstract interface class LegalRepository {
  Future<Either<Failure, LegalListEntity>> getTermsAndConditions();
  Future<Either<Failure, LegalListEntity>> getPrivacyPolicy();
}
