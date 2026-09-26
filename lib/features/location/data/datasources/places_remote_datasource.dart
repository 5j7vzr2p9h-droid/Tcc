import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';
import '../models/branch_model.dart';
import '../models/suggested_place_model.dart';

abstract interface class PlacesRemoteDatasource {
  Future<List<SuggestedPlaceModel>> searchPlace({
    required String query,
    required double lat,
    required double lng
  });

  Future<List<double>> getPlaceCoordinates(String placeId);

  Future<BranchModel> getBranch({required double lat, required double lng});
}

final class PlacesRemoteDatasourceImpl implements PlacesRemoteDatasource{
  final Dio _eMenuDio, _googlePlacesDio;

  const PlacesRemoteDatasourceImpl({
    required this._eMenuDio,
    required this._googlePlacesDio
  });

  @override
  Future<List<SuggestedPlaceModel>> searchPlace({
    required String query,
    required double lat,
    required double lng
  }) async{
    try{
      final Response response = await _googlePlacesDio.post(
        ":autocomplete",
        data: {
          "input": query,
          "locationBias": {
            "circle": {
              "center": {
                "latitude": lat,
                "longitude": lng
              },
              "radius": 5000.0
            }
          }
        }
      );
      final List<SuggestedPlaceModel> suggestedPlaces = (response.data["suggestions"] as List)
        .map<SuggestedPlaceModel>((json) => SuggestedPlaceModel.fromJson(json["placePrediction"])).toList();
      return suggestedPlaces;
    }on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }

  @override
  Future<List<double>> getPlaceCoordinates(String placeId) async{
    try{
      final Response response = await _googlePlacesDio.get(
        "/$placeId",
        options: Options(
          headers: const <String, String>{
            "X-Goog-FieldMask": "location",
          }
        )
      );
      return <double>[
        (response.data["location"]["latitude"] as num).toDouble(),
        (response.data["location"]["longitude"] as num).toDouble()
      ];
    }on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }

  @override
  Future<BranchModel> getBranch({required double lat, required double lng}) async{
    try{
      final Response response = await _eMenuDio.post(
        ApiEndpoints.locationResolve,
        data: {
          "latitude": lat,
          "longitude": lng
        }
      );
      return BranchModel.fromJson(response.data);
    }on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }
}