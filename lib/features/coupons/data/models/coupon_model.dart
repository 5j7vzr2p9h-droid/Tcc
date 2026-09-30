import '../../../../core/enums/coupon_status.dart';
import '../../../../core/enums/coupon_type.dart';
import '../../domain/entities/coupon_entity.dart';

final class const CouponModel({
  required super.code,
  required super.title,
  required super.typeText,
  required super.subtitle,
  required super.notes,
  required super.type,
  required super.expirationDate,
  required super.remainingUses,
  required super.totalUses,
  required super.status
}) extends CouponEntity{

  factory CouponModel.fromJson(dynamic json)
  => CouponModel(
    code: json["code"]??'',
    title: json["title"]??'',
    typeText: json["typeText"]??'',
    subtitle: json["subtitle"]??'',
    notes: json["notes"]??'',
    type: CouponType.fromJson(json["type"]),
    expirationDate: DateTime.parse(json["expirationDate"]).toLocal(),
    remainingUses: json["remainingUses"]??0,
    totalUses: json["totalUses"]??0,
    status: CouponStatus.fromJson(json["status"])
  );
}
