import '../../../../core/errors/failures.dart';
import '../../../delivery/domain/entities/suggested_place_entity.dart';
import '../../domain/entities/branch_entity.dart';

sealed class SelectLocationState {
  const new();
}

final class SelectLocationInitialState extends SelectLocationState{
  const new();
}

final class SelectLocationLoadingState extends SelectLocationState{
  const new();
}

final class SelectLocationInitializationFailureState extends SelectLocationState{
  final Failure failure;

  const new(this.failure);
}

final class SelectLocationGetDeviceLocationSuccessState extends SelectLocationState{
  final List<double> myLocationCoordinates;

  const new(this.myLocationCoordinates);
}

final class SearchPlaceLoadingState extends SelectLocationState{
  final List<double> myLocationCoordinates;

  const new(this.myLocationCoordinates);
}

final class SearchPlaceFailureState extends SelectLocationState{
  final List<double> myLocationCoordinates;
  final Failure failure;

  const new({
    required this.myLocationCoordinates,
    required this.failure
  });
}

final class SearchPlaceSuccessState extends SelectLocationState{
  final List<double> myLocationCoordinates;
  final List<SuggestedPlaceEntity> suggestedPlaces;

  const new({
    required this.myLocationCoordinates,
    required this.suggestedPlaces
  });
}

final class SelectPlaceLoadingState extends SelectLocationState{
  final List<double> myLocationCoordinates;

  const new(this.myLocationCoordinates);
}

final class SelectPlaceFailureState extends SelectLocationState{
  final List<double> myLocationCoordinates;
  final Failure failure;

  const new({
    required this.myLocationCoordinates,
    required this.failure
  });
}

final class SelectPlaceSuccessState extends SelectLocationState{
  final List<double> myLocationCoordinates, selectedPlaceCoordinates;

  const new({
    required this.myLocationCoordinates,
    required this.selectedPlaceCoordinates
  });
}

final class const ConfirmingLocationState({
  required final List<double> myLocationCoordinates,
}) extends SelectLocationState;

final class const ConfirmLocationSuccessState({
  required final List<double> myLocationCoordinates,
  required final BranchEntity branch
}) extends SelectLocationState;

final class const ConfirmLocationFailureState({
  required final List<double> myLocationCoordinates,
  required final Failure failure
}) extends SelectLocationState;