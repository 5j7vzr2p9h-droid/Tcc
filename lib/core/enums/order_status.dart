enum OrderStatus {
  orderSent,
  preparing,
  readyForPickup,
  delivering,
  completed,
  cancelled;

  static OrderStatus fromJson(String value)
  => OrderStatus.values.byName(value.toLowerCase());
}