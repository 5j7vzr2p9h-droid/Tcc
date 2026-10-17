import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/saved_addresses_repository.dart';

final class const SetAsDefaultAddressUsecase(final SavedAddressesRepository _repository){

  Future<Either<Failure, Unit>> call(int id)
  => _repository.setAsDefaultAddress(id);
}