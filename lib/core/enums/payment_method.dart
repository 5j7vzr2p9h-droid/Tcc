/// Checkout payment methods, fixed in the app instead of coming from the API.
enum PaymentMethod {
  // TODO: Make sure these ids match the backend payment method ids.
  cash(id: 1),
  instaPay(id: 2),
  vodafoneCash(id: 3);

  /// Backend id sent with the checkout request.
  final int id;

  const PaymentMethod({required this.id});
}
