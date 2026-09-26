import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/legal_section_entity.dart';

final class LegalSectionModel extends LegalSectionEntity {
  const new({
    required super.title,
    required super.body,
    required super.icon
  });

  factory LegalSectionModel.fromJson(dynamic json)
  => LegalSectionModel(
    title: json["title"],
    body: json["body"],
    icon: json["icon"]
  );
}

final class LegalSectionTypeAdapter extends TypeAdapter<LegalSectionModel>{
  @override
  LegalSectionModel read(BinaryReader reader)
  => LegalSectionModel(
    title: reader.readString(),
    body: reader.readString(),
    icon: reader.read()
  );

  @override
  int get typeId => 4;

  @override
  void write(BinaryWriter writer, LegalSectionModel obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.body);
    writer.write<String?>(obj.icon);
  }
}
