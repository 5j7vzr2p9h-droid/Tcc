import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';
import '../models/address_model.dart';

abstract interface class const SavedAddressesRemoteDatasource(){
  Future<List<AddressModel>> getSavedAddresses();
  Future<void> setAsDefaultAddress(int id); 
  Future<List<AddressModel>> deleteAddress(int id);
}

final class SavedAddressesRemoteDatasourceImpl(final Dio _dio) implements SavedAddressesRemoteDatasource{
  
  @override
  Future<List<AddressModel>> getSavedAddresses() async{
    try{
      final Response response = await _dio.get(ApiEndpoints.profileAddresses);
      final List<AddressModel> addresses = (response.data as List).map<AddressModel>(
        (json) => AddressModel.fromJson(json)
      ).toList();
      return addresses;
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(_){
      throw const UnknownException();
    }
  }

  @override
  Future<void> setAsDefaultAddress(int id) async{
    try{
      await _dio.put(
        "${ApiEndpoints.profileAddresses}/$id/set-default",
      );
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(_){
      throw const UnknownException();
    }
  }

  @override
  Future<List<AddressModel>> deleteAddress(int id) async{
    try{
      final Response response = await _dio.delete(
        "${ApiEndpoints.profileAddresses}/$id/delete",
      );
      final List<AddressModel> addresses = (response.data as List).map<AddressModel>(
        (json) => AddressModel.fromJson(json)
      ).toList();
      return addresses;
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(_){
      throw const UnknownException();
    }
  }
}