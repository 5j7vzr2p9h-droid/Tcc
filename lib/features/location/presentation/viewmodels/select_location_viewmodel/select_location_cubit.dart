import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/suggested_place_entity.dart';
import '../../../domain/entities/branch_entity.dart';
import '../../../domain/usecases/get_branch_usecase.dart';
import '../../../domain/usecases/get_device_location_usecase.dart';
import '../../../domain/usecases/get_place_coordinates_usecase.dart';
import '../../../domain/usecases/search_places_usecase.dart';
import 'select_location_state.dart';

final class SelectLocationCubit extends Cubit<SelectLocationState>{
  List<double> _coordinates = <double>[
    30.9763126,
    31.160289,15
  ];

  late List<double>? myLocationCoordinates;

  final GetDeviceLocationUsecase _getDeviceLocationUsecase;
  final SearchPlacesUsecase _searchPlacesUsecasse;
  final GetPlaceCoordinatesUsecase _getPlaceCoordinatesUsecase;
  final GetBranchUsecase _getBranchUsecase;

  SelectLocationCubit({
    required this._getDeviceLocationUsecase,
    required this._searchPlacesUsecasse,
    required this._getPlaceCoordinatesUsecase,
    required this._getBranchUsecase
  }): super(const SelectLocationInitialState());

  void getDeviceLocation() async{
    emit(const SelectLocationLoadingState());
    (await _getDeviceLocationUsecase()).fold(
      (Failure failure) => emit(SelectLocationInitializationFailureState(failure)),
      (List<double> coordinates) {
        emit(SelectLocationGetDeviceLocationSuccessState(_coordinates = coordinates));
      }
    );
  }

  void searchPlace(String query) async{
    emit(SearchPlaceLoadingState(_coordinates));
    (await _searchPlacesUsecasse(query)).fold(
      (Failure failure) => emit(
        SearchPlaceFailureState(
          myLocationCoordinates: _coordinates,
          failure: failure
        )
      ),
      (List<SuggestedPlaceEntity> suggestedPlaces)
      => emit(
        SearchPlaceSuccessState(
          myLocationCoordinates: _coordinates,
          suggestedPlaces: suggestedPlaces
        )
      )
    );
  }

  void selectPlace(String placeId) async{
    emit(SelectPlaceLoadingState(_coordinates));
    (await _getPlaceCoordinatesUsecase(placeId)).fold(
      (Failure failure) => emit(
        SelectPlaceFailureState(
          myLocationCoordinates: _coordinates,
          failure: failure
        )
      ),
      (List<double> placeCoordinates)
      => emit(
        SelectPlaceSuccessState(
          myLocationCoordinates: _coordinates,
          selectedPlaceCoordinates: placeCoordinates
        )
      )
    );
  }

  void confirmLocation({
    required double lat,
    required double lng
  }) async{
    emit(ConfirmingLocationState(myLocationCoordinates: _coordinates));
    (await _getBranchUsecase(lat: lat, lng: lng)).fold(
      (Failure failure) => emit(ConfirmLocationFailureState(
        myLocationCoordinates: _coordinates,
        failure: failure
      )),
      (BranchEntity branch) => emit(ConfirmLocationSuccessState(
        myLocationCoordinates: _coordinates,
        branch: branch
      ))
    );
  }}