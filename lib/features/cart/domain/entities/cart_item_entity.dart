import '../../../root/domain/entities/item_entity.dart';

class CartItemEntity {
  final int productId, quantity;
  final String name, image, description, notes;
  final double basePrice;
  final MenuSizeEntity? size;
  final List<AddonEntity> addons;
  /// The picked [ItemEntity.notes].
  final List<NoteEntity> freeAdditions;

  const new({
    required this.productId,
    required this.name,
    required this.image,
    required this.description,
    required this.basePrice,
    required this.size,
    required this.addons,
    required this.freeAdditions,
    required this.notes,
    required this.quantity
  });

  /// Same product with the same size, addons, free additions and notes shares one cart entry.
  String get key{
    final List<int> addonIds = addons.map<int>((AddonEntity addon) => addon.id).toList()..sort();
    final List<int> freeAdditionIds = freeAdditions.map<int>((NoteEntity note) => note.id).toList()..sort();
    return "$productId|${size?.id}|${addonIds.join(",")}|${freeAdditionIds.join(",")}|${notes.trim()}";
  }

  /// The size price replaces [basePrice], it isn't added on top of it.
  double get unitPrice => addons.fold<double>(
    size?.price ?? basePrice,
    (double total, AddonEntity addon) => total + addon.price
  );

  double get totalPrice => unitPrice * quantity;
}
