import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/usecases/delete_address_usecase.dart';
import '../../../domain/usecases/get_saved_addresses_usecase.dart';
import '../../../domain/usecases/set_as_default_address_usecase.dart';
import 'saved_addresses_state.dart';

final class SavedAddressesCubit extends Cubit<SavedAddressesState>{
  final GetSavedAddressesUsecase _getSavedAddressesUsecase;
  final SetAsDefaultAddressUsecase _setAsDefaultAddressUsecase;
  final DeleteAddressUsecase _deleteAddressUsecase;

  SavedAddressesCubit({
    required this._getSavedAddressesUsecase,
    required this._setAsDefaultAddressUsecase,
    required this._deleteAddressUsecase
  }): super(const SavedAddressesInitialState());

  late final List<AddressEntity> _addresses;

  void init() async{
    emit(const SavedAddressesLoadingState());

    final Either<Failure, List<AddressEntity>> result = await _getSavedAddressesUsecase();

    if(isClosed)
      return;

    result.fold(
      (Failure failure) => emit(SavedAddressesGetFailureState(failure)),
      (List<AddressEntity> addresses) => emit(SavedAddressesGetSuccessState(_addresses = addresses))
    );
  }

  void setAsDefaultAddress(int id) async{
    final int entityIndex = _addresses.indexWhere((AddressEntity e) => e.id == id);
    _toggleDefaultAddress(entityIndex);

    emit(SetAsDefaultAddressSuccessState(_addresses));

    final Either<Failure, Unit> result = await _setAsDefaultAddressUsecase(id);

    if(isClosed)
      return;

    result.fold<void>(
      (Failure failure) {
        _toggleDefaultAddress(entityIndex);
        emit(SetAsDefaultAdressFailureState(addresses: _addresses, failure: failure));
      },
      (Unit unit){}
    );
  }

  void _toggleDefaultAddress(int index)
  => _addresses[index].isDefault = !_addresses[index].isDefault;
}