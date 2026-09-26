import '../../../../core/enums/notification_type.dart';

class NotificationEntity {
  final String title, description;
  final DateTime date;
  final NotificationType type;
  final bool isUnread;

  const new({
    required this.title,
    required this.description,
    required this.date,
    required this.type,
    this.isUnread = false,
  });
}
