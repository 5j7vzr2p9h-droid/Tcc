import '../../../location/domain/repositories/location_repository.dart';

final class GetAddressNameUsecase {
  final LocationRepository _repository;

  const GetAddressNameUsecase(this._repository);

  Future<String?> call(List<double> coordinates)
  => _repository.getAddressName(coordinates);
}