import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/location_repository.dart';

final class AddAddressUsecase(final LocationRepository _repository){

  Future<Either<Failure, Unit>> call()
  => _repository.addAddress();
}