enum CouponStatus {
  active,
  expired;

  /// Any status other than active (expired, used up, ...) is treated as expired.
  static CouponStatus fromJson(String? value)
  => value?.toLowerCase() == active.name ? active : expired;
}
