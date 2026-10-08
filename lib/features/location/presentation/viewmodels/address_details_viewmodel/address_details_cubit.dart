import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/region_entity.dart';
import '../../../domain/usecases/add_address_usecase.dart';
import '../../../domain/usecases/get_regions_usecase.dart';
import 'address_details_state.dart';

final class AddressDetailsCubit extends Cubit<AddressDetailsState>{
  final GetRegionsUsecase _getRegionsUsecase;
  final AddAddressUsecase _addAddressUsecase;

  AddressDetailsCubit({
    required this._getRegionsUsecase,
    required this._addAddressUsecase
  }): super (const AddressDetailsInitialState());

  late List<RegionEntity> _regions;

  void getRegions() async{
    emit(const AddressDetailsLoadingState());
    (await _getRegionsUsecase()).fold(
      (Failure failure) => emit(AddressDetailsFailureState(failure)),
      (List<RegionEntity> regions) => emit(AddressDetailsSuccessState(_regions = regions))
    );
  }

  void addAddress() async{
    emit(AddingAddressState(_regions));

    final Either<Failure, Unit> result = await _addAddressUsecase();

    if(isClosed)
      return;
    
    result.fold(
      (Failure failure) => emit(
        AddAddressFailureState(
          regions: _regions,
          failure: failure
        )
      ),
      (Unit unit) => emit(AddAddressSuccessState(_regions))
    );
  }
}