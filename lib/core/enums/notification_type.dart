/// Declared in the backend's order, so [index] is the value the API uses.
enum NotificationType {
  order,
  offer,
  update,
  coupon;

  static NotificationType fromJson(int value) => values[value];
}
