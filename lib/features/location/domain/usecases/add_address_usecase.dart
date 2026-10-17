import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/location_repository.dart';

final class AddAddressUsecase(final LocationRepository _repository){

  Future<Either<Failure, Unit>> call({
    required String addressText,
    required bool isDefault,
    required double lat,
    required double lng
  })
  => _repository.addAddress(
    addressText: addressText,
    isDefault: isDefault,
    lat: lat,
    lng: lng
  );
}