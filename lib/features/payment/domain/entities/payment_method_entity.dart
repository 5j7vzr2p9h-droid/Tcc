import 'package:flutter/widgets.dart';

final class PaymentMethodEntity {
  final String title, description;
  final Widget icon;

  const new({
    required this.title,
    required this.description,
    required this.icon
  });
}
