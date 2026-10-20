import '../../../../core/enums/notification_type.dart';

class NotificationEntity {
  final int id;
  final String title, description;
  final DateTime date;
  final NotificationType type;
  final Map<String, String> data;
  final bool isUnread;

  const new({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.type,
    this.data = const <String, String>{},
    this.isUnread = false,
  });
}
