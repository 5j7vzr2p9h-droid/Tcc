abstract interface class Failure {
  const Failure();
}

final class OfflineFailure extends Failure{

  const OfflineFailure();
}

final class ServerFailure extends Failure{
  final String? message;

  const ServerFailure(this.message);
}

final class UnknownFailure extends Failure{
  const UnknownFailure();
}

final class LocationDisabledFailure extends Failure{
  const LocationDisabledFailure();
}

final class LocationTimeOutFailure extends Failure{
  const LocationTimeOutFailure();
}

final class LocationUnknownFailure extends Failure{
  const LocationUnknownFailure();
}

final class PermissionAccessDeniedFailure extends Failure{
  const PermissionAccessDeniedFailure();
}