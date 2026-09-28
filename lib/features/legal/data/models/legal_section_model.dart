import 'package:hive_flutter/hive_flutter.dart';

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

final class LegalSectionTypeAdapter extends TypeAdapter<LegalSectionModel>{
  @override
  LegalSectionModel read(BinaryReader reader)
  => LegalSectionModel(
    title: reader.readString(),
    body: reader.readString(),
  );

  @override
  int get typeId => 4;

  @override
  void write(BinaryWriter writer, LegalSectionModel obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.body);
  }
}
