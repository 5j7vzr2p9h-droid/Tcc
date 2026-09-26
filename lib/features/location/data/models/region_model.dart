import '../../domain/entities/region_entity.dart';

final class const RegionModel({
  required super.title,
  required super.id
}) extends RegionEntity {

  factory RegionModel.fromJson(dynamic json)
  => RegionModel(
    title: json["addressLine"],
    id: json["id"]
  );
}