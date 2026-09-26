import 'package:flutter/material.dart';

import '../../../../core/enums/coupon_status.dart';

final class CouponEntity {
  final String code, title;
  final String? discount;
  final int minimumOrder;
  final DateTime expiryDate;
  final int? remainingUses, totalUses;
  final Color color;
  final CouponStatus status;

  const new({
    required this.code,
    required this.title,
    required this.minimumOrder,
    required this.expiryDate,
    required this.color,
    this.discount,
    this.remainingUses,
    this.totalUses,
    this.status = .active
  });

  bool get isFreeShipping => discount == null;

  bool get hasUnlimitedUses => remainingUses == null || totalUses == null;
}
