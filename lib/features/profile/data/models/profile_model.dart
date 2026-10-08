import '../../domain/entities/profile_entity.dart';

final class const ProfileModel({
  required super.name,
  required super.phone,
  required super.address,
  required super.profileImageUrl
}) extends ProfileEntity{

  factory ProfileModel.fromJson(dynamic json)
  => ProfileModel(
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    profileImageUrl: json["profileImageUrl"]
  );
}