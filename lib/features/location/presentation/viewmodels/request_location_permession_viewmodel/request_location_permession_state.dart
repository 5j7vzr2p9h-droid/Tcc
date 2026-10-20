import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/branch_entity.dart';

sealed class const RequestLocationPermessionState();

final class const RequestLocationPermessionInitialState() extends RequestLocationPermessionState;

final class const RequestLocationPermessionLoadingState() extends RequestLocationPermessionState;

final class const RequestLocationPermessionSuccessState(final BranchEntity branch) extends RequestLocationPermessionState;

final class const RequestLocationPermessionFailureState(final Failure failure) extends RequestLocationPermessionState;