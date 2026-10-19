import 'package:firebase_messaging/firebase_messaging.dart';

abstract interface class FcmService{
  Future<String> get registerAndGetId;
  Stream<String> get onRegistered;
}

final class const FcmServiceImpl(
  final FirebaseMessaging _messaging
) implements FcmService{
  
  @override
  Future<String> get registerAndGetId async{
    final Future<String> idFuture = _messaging.onRegistered.first.timeout(
      const Duration(seconds: 15),
    );

    await _messaging.register();

    return idFuture;
  }


  @override
  Stream<String> get onRegistered => _messaging.onRegistered;
}