import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/address_entity.dart';
import '../repositories/saved_addresses_repository.dart';

final class const DeleteAddressUsecase(final SavedAddressesRepository _repository){

  Future<Either<Failure,List<AddressEntity>>> call(int id)
  => _repository.deleteAddress(id);
}