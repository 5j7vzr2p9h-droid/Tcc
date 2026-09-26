import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';
import '../models/legal_list_model.dart';

abstract interface class LegalRemoteDatasource {
  Future<LegalListModel> getTermsAndConditions();
  Future<LegalListModel> getPrivacyPolicy();
}

final class LegalRemoteDatasourceImpl implements LegalRemoteDatasource{
  final Dio _dio;

  const LegalRemoteDatasourceImpl(this._dio);

  @override
  Future<LegalListModel> getPrivacyPolicy() => _getLegalList(ApiEndpoints.privacyPolicy);

  @override
  Future<LegalListModel> getTermsAndConditions() => _getLegalList(ApiEndpoints.termsAndConditions);

  Future<LegalListModel> _getLegalList(String endpoint) async{
    try{
      print("===========================REquesting");
      final Response response = await _dio.get(endpoint);
      print(response.data);
      return LegalListModel.fromJson(response.data);
    }on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }
}
