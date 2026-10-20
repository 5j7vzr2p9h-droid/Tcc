import '../../../../core/enums/notification_type.dart';
import '../../domain/entities/notification_entity.dart';

final class NotificationModel extends NotificationEntity {
  const new({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
    required super.type,
    super.data
  });

  factory NotificationModel.fromJson(dynamic json)
  => NotificationModel(
    id: json["id"],
    title: json["title"] ?? '',
    description: json["body"] ?? '',
    date: DateTime.parse(json["date"]).toLocal(),
    type: NotificationType.fromJson(json["type"]),
    data: (json["data"] as Map?)?.map<String, String>(
      (key, value) => MapEntry<String, String>(key.toString(), value.toString())
    ) ?? const <String, String>{}
  );
}
