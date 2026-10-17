import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usecases/add_address_usecase.dart';
import 'address_details_state.dart';

final class AddressDetailsCubit extends Cubit<AddressDetailsState>{
  final AddAddressUsecase _addAddressUsecase;

  AddressDetailsCubit(this._addAddressUsecase): super (const AddressDetailsInitialState());

  void addAddress({
    required String addressText,
    required bool isDefault,
    required double lat,
    required double lng
  }) async{
    emit(const AddingAddressState());

    final Either<Failure, Unit> result = await _addAddressUsecase(
      addressText: addressText,
      isDefault: isDefault,
      lat: lat,
      lng: lng
    );

    if(isClosed)
      return;
    
    result.fold(
      (Failure failure) => emit(
        AddAddressFailureState(failure)
      ),
      (Unit unit) => emit(const AddAddressSuccessState())
    );
  }
}