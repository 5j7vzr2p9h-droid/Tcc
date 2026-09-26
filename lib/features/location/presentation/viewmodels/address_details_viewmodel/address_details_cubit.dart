import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/region_entity.dart';
import '../../../domain/usecases/get_regions_usecase.dart';
import 'address_details_state.dart';

final class AddressDetailsCubit extends Cubit<AddressDetailsState>{
  final GetRegionsUsecase _getRegionsUsecase;

  AddressDetailsCubit(this._getRegionsUsecase): super (const AddressDetailsInitialState());

  void getRegions() async{
    emit(const AddressDetailsLoadingState());
    (await _getRegionsUsecase()).fold(
      (Failure failure) => emit(AddressDetailsFailureState(failure)),
      (List<RegionEntity> regions) => emit(AddressDetailsSuccessState(regions))
    );
  }
}