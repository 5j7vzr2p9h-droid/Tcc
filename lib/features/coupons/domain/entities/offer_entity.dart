final class OfferEntity {
  final String title, description, image;
  final DateTime validUntil;

  const new({
    required this.title,
    required this.description,
    required this.image,
    required this.validUntil
  });
}
