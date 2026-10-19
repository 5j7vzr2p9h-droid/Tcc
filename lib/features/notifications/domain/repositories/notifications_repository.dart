import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract interface class const NotificationsRepository(){
  Future<Either<Failure, Unit>> enableNotifications();
  Future<Either<Failure, Unit>> disableNotifications();
}