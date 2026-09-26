final class SavedAddressEntity {
  final String label, address, details, phoneNumber;
  final bool isDefault;

  const new({
    required this.label,
    required this.address,
    required this.details,
    required this.phoneNumber,
    this.isDefault = false
  });
}
