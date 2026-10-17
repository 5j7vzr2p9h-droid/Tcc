import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/address_entity.dart';

sealed class const SavedAddressesState();

final class const SavedAddressesInitialState() extends SavedAddressesState;

final class const SavedAddressesLoadingState() extends SavedAddressesState;

final class const SavedAddressesGetSuccessState(
  final List<AddressEntity> addresses
) extends SavedAddressesState;

final class const SavedAddressesGetFailureState(
  final Failure failure
) extends SavedAddressesState;

final class const SetAsDefaultAddressSuccessState(
  final List<AddressEntity> addresses
) extends SavedAddressesState;

final class const SetAsDefaultAdressFailureState({
  required final List<AddressEntity> addresses,
  required final Failure failure
}) extends SavedAddressesState;