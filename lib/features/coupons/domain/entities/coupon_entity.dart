import '../../../../core/enums/coupon_status.dart';
import '../../../../core/enums/coupon_type.dart';

class CouponEntity {
  final String code, title, typeText, subtitle, notes;
  final CouponType type;
  final DateTime expirationDate;
  final int remainingUses, totalUses;
  final CouponStatus status;

  const new({
    required this.code,
    required this.title,
    required this.typeText,
    required this.subtitle,
    required this.notes,
    required this.type,
    required this.expirationDate,
    required this.remainingUses,
    required this.totalUses,
    required this.status
  });

  bool get hasUnlimitedUses => totalUses <= 0;
}
