import 'notification_entity.dart';

class NotificationsGroupEntity {
  final DateTime date;
  final List<NotificationEntity> notifications;

  const new({
    required this.date,
    required this.notifications,
  });
}
