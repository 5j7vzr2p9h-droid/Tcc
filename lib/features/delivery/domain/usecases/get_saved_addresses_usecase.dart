import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/address_entity.dart';
import '../repositories/saved_addresses_repository.dart';

final class const GetSavedAddressesUsecase(final SavedAddressesRepository _repository){

  Future<Either<Failure, List<AddressEntity>>> call()
  => _repository.getAddresses();
}