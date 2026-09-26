import '../../domain/entities/branch_entity.dart';

final class BranchModel extends BranchEntity{
  const new({
    required super.id,
    required super.name,
    required super.address,
    required super.phone
  });

  factory BranchModel.fromJson(dynamic json)
  => BranchModel(
    id: json["branchId"],
    name: json["branch"]?["name"],
    address: json["branch"]?["address"],
    phone: json["branch"]?["phone"]
  );

}