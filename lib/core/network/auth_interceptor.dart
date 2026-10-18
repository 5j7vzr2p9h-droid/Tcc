
import 'dart:ui' show VoidCallback;

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/api_endpoints.dart';

final class AuthInterceptor({
  required final FlutterSecureStorage _secureStorage,
  required final Dio _emenuDio,
  required final Dio _refreshDio,
  required final VoidCallback _onSessionExpired,
}) extends Interceptor {
  Future<String>? _refreshFuture;

  Future<String> _refreshAccessToken(String refreshToken) async {
    final Response response = await _refreshDio.get(
      ApiEndpoints.refreshToken,
      data: <String, String>{
        'refreshToken': refreshToken,
      },
    );

    final String accessToken =
        response.data['access_token'] as String;
    final String newRefreshToken =
        response.data['refresh_token'] as String;

    await _secureStorage.write(
      key: 'access_token',
      value: accessToken,
    );

    await _secureStorage.write(
      key: 'refresh_token',
      value: newRefreshToken,
    );

    _emenuDio.options.headers['access_token'] = accessToken;

    return accessToken;
  }

  Future<String> _getOrRefreshToken(String refreshToken) {
    final Future<String>? existingFuture = _refreshFuture;

    if (existingFuture != null) {
      return existingFuture;
    }

    final Future<String> newFuture =
        _refreshAccessToken(refreshToken);

    _refreshFuture = newFuture;

    return newFuture.whenComplete(() => _refreshFuture = null);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    // Prevent refreshing more than once for the same request.
    if (err.requestOptions.extra['retried'] == true) {
      _onSessionExpired();
      return handler.next(err);
    }

    try {
      final String? currentToken =
          await _secureStorage.read(key: 'access_token');

      final String? requestToken =
          err.requestOptions.headers['access_token'];

      // Another request may have already refreshed the token.
      if (currentToken != null &&
          requestToken != currentToken) {
        err.requestOptions.headers['access_token'] =
            currentToken;
        err.requestOptions.extra['retried'] = true;

        final Response response =
            await _emenuDio.fetch(err.requestOptions);

        return handler.resolve(response);
      }

      final String? refreshToken =
          await _secureStorage.read(key: 'refresh_token');

      if (refreshToken == null) {
        _onSessionExpired();
        return handler.next(err);
      }

      // All concurrent requests share the same refresh operation.
      final String newToken =
          await _getOrRefreshToken(refreshToken);

      err.requestOptions.headers['access_token'] = newToken;
      err.requestOptions.extra['retried'] = true;

      final Response response =
          await _emenuDio.fetch(err.requestOptions);

      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.reject(e);
    } catch (e) {
      return handler.reject(
        DioException(
          error: e,
          requestOptions: err.requestOptions,
          type: .unknown,
        ),
      );
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }
}