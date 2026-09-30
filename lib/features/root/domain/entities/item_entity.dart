class ItemEntity {
  final int id, categoryId;
  final String name, image, description;
  final bool isFeatured, hasSizes, isFavorite;
  final double price;
  /// Paid additions.
  final List<AddonEntity> addons;
  /// Free additions.
  final List<NoteEntity> notes;
  final List<ConditionalGroupEntity> conditionalGroups;
  final List<MenuSizeEntity> sizes;

  const new({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.image,
    required this.description,
    required this.isFeatured,
    required this.hasSizes,
    required this.isFavorite,
    required this.price,
    required this.addons,
    required this.notes,
    required this.conditionalGroups,
    required this.sizes
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

class NoteEntity{
  final int id;
  final String name;

  const new({
    required this.id,
    required this.name
  });
}

class ConditionalGroupEntity{
  final int id, minSelection, maxSelection;
  final String name;
  final List<ConditionalOptionEntity> options;

  const new({
    required this.id,
    required this.name,
    required this.minSelection,
    required this.maxSelection,
    required this.options
  });
}

/// An addon that belongs to a [ConditionalGroupEntity].
class ConditionalOptionEntity extends AddonEntity{
  /// When false, picking this option clears the rest of the group, so it's always picked alone.
  final bool allowCombine;

  const new({
    required super.id,
    required super.name,
    required super.price,
    required this.allowCombine
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
