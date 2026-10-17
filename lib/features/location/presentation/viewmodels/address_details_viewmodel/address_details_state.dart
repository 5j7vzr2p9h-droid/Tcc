import '../../../../../core/errors/failures.dart';

sealed class const AddressDetailsState();

final class const AddressDetailsInitialState() extends AddressDetailsState;

final class const AddingAddressState() extends AddressDetailsState;

final class const AddAddressFailureState(
  final Failure failure
) extends AddressDetailsState;

final class const AddAddressSuccessState() extends AddressDetailsState;