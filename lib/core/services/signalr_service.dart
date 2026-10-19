import 'package:signalr_netcore/signalr_client.dart';

abstract interface class const SignalrService() {
  void startConnection();
  void closeConnection();
  void on(String methodName, void Function(List<Object?>?) handler);
}

final class const SignalrServiceImpl(
  final HubConnection _connection
) implements SignalrService{

  @override
  void startConnection() => _connection.start();

  @override
  void closeConnection() => _connection.stop();

  @override
  void on(String methodName, void Function(List<Object?>?) handler)
  => _connection.on(methodName, handler);
}