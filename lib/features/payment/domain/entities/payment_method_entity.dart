class PaymentMethodEntity {
  final int id;
  final String name, code;
  final bool requiresProof;

  const new({
    required this.id,
    required this.name,
    required this.code,
    required this.requiresProof
  });
}
