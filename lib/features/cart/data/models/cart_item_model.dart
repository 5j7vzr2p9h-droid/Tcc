import '../../../root/data/models/item_model.dart';
import '../../../root/domain/entities/item_entity.dart';
import '../../domain/entities/cart_item_entity.dart';

final class CartItemModel extends CartItemEntity{
  /// Hive orders String keys alphabetically, so this keeps the cart in the order items were added.
  final DateTime addedAt;

  const new({
    required super.productId,
    required super.name,
    required super.image,
    required super.description,
    required super.basePrice,
    required super.size,
    required super.addons,
    required super.freeAdditions,
    required super.notes,
    required super.quantity,
    required this.addedAt
  });

  factory CartItemModel.fromEntity(CartItemEntity item, {required DateTime addedAt})
  => CartItemModel(
    productId: item.productId,
    name: item.name,
    image: item.image,
    description: item.description,
    basePrice: item.basePrice,
    size: item.size,
    addons: item.addons,
    freeAdditions: item.freeAdditions,
    notes: item.notes,
    quantity: item.quantity,
    addedAt: addedAt
  );

  factory CartItemModel.fromJson(dynamic json)
  => CartItemModel(
    productId: json["productId"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    basePrice: (json["basePrice"] as num).toDouble(),
    size: json["size"] == null ? null : MenuSizeModel.fromJson(json["size"]),
    addons: (json["addons"] as List).map<AddonModel>(AddonModel.fromJson).toList(),
    freeAdditions: (json["freeAdditions"] as List?)?.map<NoteModel>(NoteModel.fromJson).toList() ?? const <NoteModel>[],
    notes: json["notes"],
    quantity: json["quantity"],
    addedAt: DateTime.fromMillisecondsSinceEpoch(json["addedAt"])
  );

  Map<String, dynamic> toJson()
  => <String, dynamic>{
    "productId": productId,
    "name": name,
    "image": image,
    "description": description,
    "basePrice": basePrice,
    "size": size == null ? null : <String, dynamic>{
      "menuSizeId": size!.id,
      "name": size!.name,
      "price": size!.price
    },
    "addons": addons.map<Map<String, dynamic>>((AddonEntity addon) => <String, dynamic>{
      "addonId": addon.id,
      "name": addon.name,
      "price": addon.price
    }).toList(),
    "freeAdditions": freeAdditions.map<Map<String, dynamic>>((NoteEntity note) => <String, dynamic>{
      "noteId": note.id,
      "name": note.name
    }).toList(),
    "notes": notes,
    "quantity": quantity,
    "addedAt": addedAt.millisecondsSinceEpoch
  };

  CartItemModel copyWith({required int quantity})
  => CartItemModel(
    productId: productId,
    name: name,
    image: image,
    description: description,
    basePrice: basePrice,
    size: size,
    addons: addons,
    freeAdditions: freeAdditions,
    notes: notes,
    quantity: quantity,
    addedAt: addedAt
  );
}
