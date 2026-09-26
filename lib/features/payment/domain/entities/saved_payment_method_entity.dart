import 'package:flutter/widgets.dart';

final class SavedPaymentMethodEntity {
  final String title;
  final String? cardLastDigits;
  final Widget icon;
  final bool isDefault;

  const new({
    required this.title,
    required this.icon,
    this.cardLastDigits,
    this.isDefault = false
  });
}
