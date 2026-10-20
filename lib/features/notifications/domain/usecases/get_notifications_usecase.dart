import 'package:dartz/dartz.dart';

import '../../../../core/entities/paginated_list_entity.dart';
import '../../../../core/enums/notification_type.dart';
import '../../../../core/errors/failures.dart';
import '../entities/notification_entity.dart';
import '../repositories/notifications_repository.dart';

final class const GetNotificationsUsecase(final NotificationsRepository _repository){

  Future<Either<Failure, PaginatedListEntity<NotificationEntity>>> call({
    required int pageIndex,
    required int pageSize,
    NotificationType? type
  }) => _repository.getNotifications(
    pageIndex: pageIndex,
    pageSize: pageSize,
    type: type
  );
}
