enum CouponType {
  percentage,
  fixedAmount;

  static CouponType fromJson(int? value)
  => value == 1 ? fixedAmount : percentage;
}
