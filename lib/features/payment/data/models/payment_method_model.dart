import '../../domain/entities/payment_method_entity.dart';

final class PaymentMethodModel({
  required super.id,
  required super.name,
  required super.code,
  required super.requiresProof
}) extends PaymentMethodEntity{

  factory PaymentMethodModel.fromJson(dynamic json)
  => PaymentMethodModel(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    requiresProof: json["requiresProof"]
  );
}