import 'package:dio/dio.dart';
import 'package:electronic_menu/core/errors/exceptions.dart';

import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';

abstract interface class const BannersRemoteDatasource(){
  Future<List<String>> getBanners();
}

final class const BannersRemoteDatasourceImpl(final Dio _dio) implements BannersRemoteDatasource{

  @override
  Future<List<String>> getBanners() async{
    try{
      final Response response = await _dio.get(
        ApiEndpoints.themeConfig,
        options: Options(
          headers: <String, dynamic>{
            "Authorization": null // So as not to get 403 (Forbidden from backend)
          }
        )
      );
      final List<String> banners = (response.data["data"][0]["homeSlider"] as List)
        .map<String>((json) => json["imageUrl"]).toList();
      return banners;
    }on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(_){
      throw const UnknownException();
    }
  }
}