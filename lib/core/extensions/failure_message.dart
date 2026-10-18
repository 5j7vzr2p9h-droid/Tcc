import 'package:flutter/material.dart';

import '../errors/failures.dart';
import 'context_l10n.dart';

extension FailureMessage on Failure{
  String mapFailureToMessage(BuildContext context)
  => switch(runtimeType){
    ServerFailure => (this as ServerFailure).message ?? context.l10n.unknownError,
    OfflineFailure => context.l10n.noInternetMessage,
    LocationDisabledFailure || LocationDisabledFailure || LocationTimeOutFailure ||
    LocationUnknownFailure || PermissionAccessDeniedFailure => context.l10n.failedToGetLocation,
    _ => context.l10n.unknownError 
  };
}