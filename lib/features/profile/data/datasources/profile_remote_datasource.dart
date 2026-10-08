import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';
import '../models/profile_model.dart';

abstract interface class ProfileRemoteDatasource {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile({
    required String? name,
    required String? address,
    required String? imagePath
  });
  Future<void> requestPhoneUpdate(String newPhone);
}

final class const ProfileRemoteDatasourceImpl(final Dio _dio) implements ProfileRemoteDatasource{

  @override
  Future<ProfileModel> getProfile() async{
    try{
      final Response response = await _dio.get(ApiEndpoints.profile);
      return ProfileModel.fromJson(response.data);
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(_){
      throw const UnknownException();
    }
  }

  @override
  Future<ProfileModel> updateProfile({
    required String? name,
    required String? address,
    required String? imagePath
  }) async{
    try{
      final Response response = await _dio.put(
        ApiEndpoints.profile,
        data: imagePath == null
          ? <String, String>{
            "name": ?name,
            "address": ?address
          }
          : FormData.fromMap(<String, dynamic>{
            "name": ?name,
            "address": ?address,
            "profileImageUrl": await MultipartFile.fromFile(imagePath)
          })
      );
      return ProfileModel.fromJson(response.data);
    }on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(_){
      throw const UnknownException();
    }
  }

  @override
  Future<void> requestPhoneUpdate(String newPhone) async{
    try{
      await _dio.post(
        ApiEndpoints.phoneChangeRequest,
        data: <String, String>{
          "newPhone": newPhone
        }
      );
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(_){
      throw const UnknownException();
    }
  }
}