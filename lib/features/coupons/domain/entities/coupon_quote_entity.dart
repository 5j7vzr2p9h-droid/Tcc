class CouponQuoteEntity {
  final String code;
  final double subtotal, discount;

  const new({
    required this.code,
    required this.subtotal,
    required this.discount
  });

  double get total => subtotal - discount;
}
