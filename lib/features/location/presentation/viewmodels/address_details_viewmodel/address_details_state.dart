import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/region_entity.dart';

sealed class const AddressDetailsState();

final class const AddressDetailsInitialState() extends AddressDetailsState;

final class const AddressDetailsLoadingState() extends AddressDetailsState;


final class const AddressDetailsFailureState(final Failure failure) extends AddressDetailsState;

final class const AddressDetailsSuccessState(
  final List<RegionEntity> regions
) extends AddressDetailsState;