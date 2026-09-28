enum OrderStatus {
  held,
  sentToKitchen,
  paid,
  cancelled;

  static OrderStatus fromJson(String value)
  => OrderStatus.values.byName(value.toLowerCase());
}