import '../../domain/entities/legal_list_entity.dart';
import 'legal_section_model.dart';

final class const LegalListModel({
  required super.lastUpdated,
  required List<LegalSectionModel> super.legalSections
}) extends LegalListEntity{

  factory LegalListModel.fromJson(dynamic json)
  => LegalListModel(
    lastUpdated: DateTime.parse(json["lastUpdated"]),
    legalSections: (json["sections"] as List).map<LegalSectionModel>(LegalSectionModel.fromJson).toList()
  );
}
