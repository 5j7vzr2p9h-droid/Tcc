class ItemEntity {
  final int id, categoryId;
  final String name, image, description;
  final bool isFeatured, hasSizes;
  final double price;
  final List<AddonEntity> obligatoryAddons, optionalAddons;
  final List<MenuSizeEntity> sizes;
  final String? addonNote;

  const new({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.image,
    required this.description,
    required this.isFeatured,
    required this.hasSizes,
    required this.price,
    required this.obligatoryAddons,
    required this.optionalAddons,
    required this.sizes,
    required this.addonNote
  });
}

class AddonEntity{
  final int id;
  final String name;
  final double price;

  const new({
    required this.id,
    required this.name,
    required this.price
  });
}

class MenuSizeEntity{
  final int id;
  final String name;
  final double price;

  const new({
    required this.id,
    required this.name,
    required this.price
  });
}