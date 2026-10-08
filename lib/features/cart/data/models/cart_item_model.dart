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
    addons: (json["addons"] as List).map<AddonEntity>(_addonFromJson).toList(),
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
      "price": addon.price,
      if(addon is ConditionalOptionEntity) ...<String, dynamic>{
        "conditionalGroupId": addon.conditionalGroupId,
        "allowCombine": addon.allowCombine
      }
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

  /// A conditional option is saved with its group id, anything else is a paid addon.
  static AddonEntity _addonFromJson(dynamic json)
  => json["conditionalGroupId"] == null
    ? AddonModel.fromJson(json)
    : ConditionalOptionModel.fromJson(json, conditionalGroupId: json["conditionalGroupId"]);

  /// A cart line as the backend expects it in the checkout body, which the coupon quote takes too.
  static Map<String, dynamic> toCheckoutLine(CartItemEntity item){
    final Map<int, List<ConditionalOptionEntity>> conditionalGroups = <int, List<ConditionalOptionEntity>>{};
    for(final AddonEntity addon in item.addons)
      if(addon is ConditionalOptionEntity)
        (conditionalGroups[addon.conditionalGroupId] ??= <ConditionalOptionEntity>[]).add(addon);

    return <String, dynamic>{
      "productId": item.productId,
      "quantity": item.quantity,
      "sizeId": ?item.size?.id,
      "addons": <Map<String, int>>[
        for(final AddonEntity addon in item.addons)
          if(addon is! ConditionalOptionEntity) _addonLine(addon)
      ],
      "notes": item.freeAdditions.map<Map<String, int>>((NoteEntity note) => <String, int>{
        "noteId": note.id
      }).toList(),
      "conditionalGroups": conditionalGroups.entries.map<Map<String, dynamic>>(
        (MapEntry<int, List<ConditionalOptionEntity>> group) => <String, dynamic>{
          "conditionalGroupId": group.key,
          "options": group.value.map<Map<String, int>>(_addonLine).toList()
        }
      ).toList(),
      "note": ?(item.notes.trim().isEmpty ? null : item.notes.trim())
    };
  }

  static Map<String, int> _addonLine(AddonEntity addon)
  => <String, int>{
    "addonId": addon.id,
    "quantity": 1
  };
}
