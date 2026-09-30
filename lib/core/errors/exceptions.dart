final class OfflineException implements Exception{
  const OfflineException();
}

final class ServerException implements Exception{
  final String? message;

  const ServerException(this.message);
}

final class UnknownException implements Exception{
  const UnknownException();
}

final class LocationDisabledException implements Exception{
  const LocationDisabledException();
}

final class LocationTimeOutException implements Exception{
  const LocationTimeOutException();
}

final class LocationUnknownException implements Exception{
  const LocationUnknownException();
}

final class PermissionAccessDeniedException implements Exception{
  const PermissionAccessDeniedException();
}