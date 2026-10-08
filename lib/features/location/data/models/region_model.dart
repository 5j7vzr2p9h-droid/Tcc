import '../../domain/entities/region_entity.dart';

final class const RegionModel({
  required super.title,
  required super.id,
  required super.deliveryFee
}) extends RegionEntity {

  factory RegionModel.fromJson(dynamic json)
  => RegionModel(
    title: json["name"],
    id: json["id"],
    deliveryFee: json["deliveryFee"]
  );
}