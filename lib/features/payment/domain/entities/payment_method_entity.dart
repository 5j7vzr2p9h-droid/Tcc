class PaymentMethodEntity {
  /// Backend code of the InstaPay payment method.
  static const String _instaPayCode = "Instapay";

  final int id;
  final String name, code;
  final bool requiresProof;

  const new({
    required this.id,
    required this.name,
    required this.code,
    required this.requiresProof
  });

  bool get isInstaPay => code == _instaPayCode;
}
