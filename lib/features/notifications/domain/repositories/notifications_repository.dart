import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/entities/paginated_list_entity.dart';
import '../../../../core/enums/notification_type.dart';
import '../../../../core/errors/failures.dart';
import '../entities/notification_entity.dart';

abstract interface class const NotificationsRepository(){
  Future<Either<Failure, Unit>> enableNotifications();
  Future<Either<Failure, Unit>> disableNotifications();
  Future<Either<Failure, PaginatedListEntity<NotificationEntity>>> getNotifications({
    required int pageIndex,
    required int pageSize,
    NotificationType? type
  });
  int get notificationsCount;
  void clearNotificatonsCounter();
  void incrementNotificationsCounter();
  Stream<void> get listenToForegroundNotificationsAndIncrement;
}