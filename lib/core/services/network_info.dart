import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo{
  Future<bool> get isDeviceConnected;
}

class NetworkInfoImpl implements NetworkInfo{
  final Connectivity _connectionChecker;

  NetworkInfoImpl(this._connectionChecker);

  @override
  Future<bool> get isDeviceConnected => _connectionChecker.checkConnectivity()
  .then<bool>((connectivityResult) => connectivityResult[0] != ConnectivityResult.none);
}