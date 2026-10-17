import '../../domain/entities/address_entity.dart';

final class AddressModel({
  required super.id,
  required super.addressText,
  required super.isDefault,
  required super.deliveryFee
}) extends AddressEntity{

  factory AddressModel.fromJson(dynamic json)
  => AddressModel(
    id: json["id"],
    addressText: json["addressText"],
    isDefault: json["isDefault"],
    deliveryFee: (json["deliveryFee"] as num).toDouble()
  );
}