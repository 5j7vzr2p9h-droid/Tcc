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
  bool _locationEnabled = false;
  List<double> _coordinates = <double>[
    30.0625736,
    31.4972822,
  ];

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
      (Failure failure) => emit(SelectLocationInitializationFailureState(
        locationEnabled: _locationEnabled,
        myLocationCoordinates: _coordinates,
        failure: failure
      )),
      (List<double> coordinates) {
        _locationEnabled = true;
        emit(SelectLocationGetDeviceLocationSuccessState(
          locationEnabled: _locationEnabled,
          myLocationCoordinates: _coordinates = coordinates
        ));
      }
    );
  }

  void searchPlace(String query) async{
    emit(SearchPlaceLoadingState(
      locationEnabled: _locationEnabled,
      myLocationCoordinates: _coordinates
    ));
    (await _searchPlacesUsecasse(query)).fold(
      (Failure failure) => emit(
        SearchPlaceFailureState(
          locationEnabled: _locationEnabled,
          myLocationCoordinates: _coordinates,
          failure: failure
        )
      ),
      (List<SuggestedPlaceEntity> suggestedPlaces)
      => emit(
        SearchPlaceSuccessState(
          locationEnabled: _locationEnabled,
          myLocationCoordinates: _coordinates,
          suggestedPlaces: suggestedPlaces
        )
      )
    );
  }

  void selectPlace(String placeId) async{
    emit(SelectPlaceLoadingState(
      locationEnabled: _locationEnabled,
      myLocationCoordinates: _coordinates
    ));
    (await _getPlaceCoordinatesUsecase(placeId)).fold(
      (Failure failure) => emit(
        SelectPlaceFailureState(
          locationEnabled: _locationEnabled,
          myLocationCoordinates: _coordinates,
          failure: failure
        )
      ),
      (List<double> placeCoordinates)
      => emit(
        SelectPlaceSuccessState(
          locationEnabled: _locationEnabled,
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
    emit(ConfirmingLocationState(
      locationEnabled: _locationEnabled,
      myLocationCoordinates: _coordinates
    ));
    (await _getBranchUsecase(lat: lat, lng: lng)).fold(
      (Failure failure) => emit(ConfirmLocationFailureState(
        locationEnabled: _locationEnabled,
        myLocationCoordinates: _coordinates,
        failure: failure
      )),
      (BranchEntity branch) => emit(ConfirmLocationSuccessState(
        locationEnabled: _locationEnabled,
        myLocationCoordinates: _coordinates,
        branch: branch
      ))
    );
  }}