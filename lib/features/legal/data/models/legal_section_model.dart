import '../../domain/entities/legal_section_entity.dart';

final class LegalSectionModel extends LegalSectionEntity {
  const new({
    required super.title,
    required super.body,
  });

  factory LegalSectionModel.fromJson(dynamic json)
  => LegalSectionModel(
    title: json["title"],
    body: json["body"],
  );
}
