import 'dart:convert';

import '../../../../core/cache/prefs.dart';
import '../../../../core/constants/cache_keys.dart';

/// Keeps the requestId of the last checkout that didn't succeed, with the body it was sent with.
abstract interface class const CheckoutLocalDatasource() {
  /// Returns the pending requestId only if it was sent with exactly the same [body].
  String? getPendingRequestId(String body);
  Future<void> savePendingRequest({
    required String requestId,
    required String body
  });
  Future<void> clearPendingRequest();
}

final class const CheckoutLocalDatasourceImpl(final Prefs _prefs) implements CheckoutLocalDatasource{
  @override
  String? getPendingRequestId(String body){
    final String? json = _prefs.getString(CacheKeys.pendingCheckout);
    if(json == null) return null;

    final Map<String, dynamic> pending = jsonDecode(json);
    return pending["body"] == body ? pending["requestId"] : null;
  }

  @override
  Future<void> savePendingRequest({
    required String requestId,
    required String body
  })
  => _prefs.setString(
    key: CacheKeys.pendingCheckout,
    value: jsonEncode(<String, String>{
      "requestId": requestId,
      "body": body
    })
  );

  @override
  Future<void> clearPendingRequest()
  => _prefs.remove(CacheKeys.pendingCheckout);
}
