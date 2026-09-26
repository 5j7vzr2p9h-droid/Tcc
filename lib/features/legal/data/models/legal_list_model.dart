import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/legal_list_entity.dart';
import 'legal_section_model.dart';

final class const LegalListModel({
  required super.lastUpdated,
  required List<LegalSectionModel> super.legalSections
}) extends LegalListEntity{

  factory LegalListModel.fromJson(dynamic json)
  => LegalListModel(
    lastUpdated: DateTime.parse(json["lastUpdated"]),
    legalSections: (json["data"] as List).map<LegalSectionModel>(LegalSectionModel.fromJson).toList()
  );
}

final class LegalListTypeAdapter extends TypeAdapter<LegalListModel>{
  @override
  LegalListModel read(BinaryReader reader)
  => LegalListModel(
    lastUpdated: DateTime.parse(reader.readString()),
    legalSections: reader.readList().cast<LegalSectionModel>().toList()
  );

  @override
  int get typeId => 5;

  @override
  void write(BinaryWriter writer, LegalListModel obj) {
    writer.writeString(obj.lastUpdated.toIso8601String());
    writer.writeList(obj.legalSections);
  }
}
