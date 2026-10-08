import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/suggested_place_entity.dart';
import '../../../domain/entities/branch_entity.dart';

sealed class const SelectLocationState();

final class const SelectLocationInitialState() extends SelectLocationState;

final class const SelectLocationLoadingState() extends SelectLocationState;

final class const SelectLocationInitializationFailureState({
  required final bool locationEnabled,
  required final List<double> myLocationCoordinates,
  required final Failure failure
}) extends SelectLocationState;

final class const SelectLocationGetDeviceLocationSuccessState({
  required final bool locationEnabled,
  required final List<double> myLocationCoordinates
}) extends SelectLocationState;

final class const SearchPlaceLoadingState({
  required final bool locationEnabled,
  required final List<double> myLocationCoordinates
}) extends SelectLocationState;

final class const SearchPlaceFailureState({
  required final bool locationEnabled,
  required final List<double> myLocationCoordinates,
  required final Failure failure
}) extends SelectLocationState;

final class const SearchPlaceSuccessState({
  required final bool locationEnabled,
  required final List<double> myLocationCoordinates,
  required final List<SuggestedPlaceEntity> suggestedPlaces
}) extends SelectLocationState;

final class const SelectPlaceLoadingState({
  required final bool locationEnabled,
  required final List<double> myLocationCoordinates
}) extends SelectLocationState;

final class const SelectPlaceFailureState({
  required final bool locationEnabled,
  required final List<double> myLocationCoordinates,
  required final Failure failure
}) extends SelectLocationState;

final class const SelectPlaceSuccessState({
  required final bool locationEnabled,
  required final List<double> myLocationCoordinates,
  required final List<double> selectedPlaceCoordinates
}) extends SelectLocationState;

final class const ConfirmingLocationState({
  required final bool locationEnabled,
  required final List<double> myLocationCoordinates,
}) extends SelectLocationState;

final class const ConfirmLocationSuccessState({
  required final bool locationEnabled,
  required final List<double> myLocationCoordinates,
  required final BranchEntity branch
}) extends SelectLocationState;

final class const ConfirmLocationFailureState({
  required final bool locationEnabled,
  required final List<double> myLocationCoordinates,
  required final Failure failure
}) extends SelectLocationState;