import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/address_entity.dart';

abstract interface class SavedAddressesRepository {
  Future<Either<Failure, List<AddressEntity>>> getAddresses();
  Future<Either<Failure, Unit>> setAsDefaultAddress(int id);
  Future<Either<Failure, List<AddressEntity>>> deleteAddress(int id);
}