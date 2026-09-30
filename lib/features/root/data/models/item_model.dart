import '../../domain/entities/item_entity.dart';

final class ItemModel extends ItemEntity{
  const new({
    required super.id,
    required super.categoryId,
    required super.name,
    required super.image,
    required super.description,
    required super.isFeatured,
    required super.hasSizes,
    required super.isFavorite,
    required super.price,
    required super.addons,
    required super.notes,
    required super.conditionalGroups,
    required super.sizes
  });

  factory ItemModel.fromJson(dynamic json)
  => ItemModel(
    id: json["id"],
    categoryId: json["categoryId"],
    name: json["name"] ?? "",
    image: json["image"] ?? "",
    description: json["description"] ?? "",
    isFeatured: json["isFeatured"] ?? false,
    hasSizes: json["hasSizes"] ?? false,
    isFavorite: json["isFavorite"] ?? false,
    price: (json["price"] as num).toDouble(),
    addons: (json["configuration"]?["addons"] as List?)
      ?.map<AddonModel>((e) => AddonModel.fromJson(e)).toList() ?? const <AddonModel>[],
    notes: (json["configuration"]?["notes"] as List?)
      ?.map<NoteModel>((e) => NoteModel.fromJson(e)).toList() ?? const <NoteModel>[],
    conditionalGroups: (json["configuration"]?["conditionalGroups"] as List?)
      ?.map<ConditionalGroupModel>((e) => ConditionalGroupModel.fromJson(e)).toList() ?? const <ConditionalGroupModel>[],
    sizes: (json["configuration"]?["sizes"] as List?)
      ?.map<MenuSizeModel>((e) => MenuSizeModel.fromJson(e)).toList() ?? const <MenuSizeModel>[]
  );

}

final class AddonModel extends AddonEntity{
  const new({
    required super.id,
    required super.name,
    required super.price
  });

  factory AddonModel.fromJson(dynamic json)
  => AddonModel(
    id: json["addonId"],
    name: json["name"] ?? "",
    price: (json["price"] as num).toDouble()
  );
}

final class NoteModel extends NoteEntity{
  const new({
    required super.id,
    required super.name
  });

  factory NoteModel.fromJson(dynamic json)
  => NoteModel(
    id: json["noteId"],
    name: json["name"] ?? ""
  );
}

final class ConditionalGroupModel extends ConditionalGroupEntity{
  const new({
    required super.id,
    required super.name,
    required super.minSelection,
    required super.maxSelection,
    required super.options
  });

  factory ConditionalGroupModel.fromJson(dynamic json)
  => ConditionalGroupModel(
    id: json["conditionalGroupId"],
    name: json["name"] ?? "",
    minSelection: json["minSelection"] ?? 0,
    maxSelection: json["maxSelection"] ?? 0,
    options: (json["options"] as List?)
      ?.map<ConditionalOptionModel>((e) => ConditionalOptionModel.fromJson(e)).toList() ?? const <ConditionalOptionModel>[]
  );
}

final class ConditionalOptionModel extends ConditionalOptionEntity{
  const new({
    required super.id,
    required super.name,
    required super.price,
    required super.allowCombine
  });

  factory ConditionalOptionModel.fromJson(dynamic json)
  => ConditionalOptionModel(
    id: json["addonId"],
    name: json["name"] ?? "",
    price: (json["price"] as num?)?.toDouble() ?? 0.0,
    allowCombine: json["allowCombine"] ?? true
  );
}

final class MenuSizeModel extends MenuSizeEntity{
  const new({
    required super.id,
    required super.name,
    required super.price
  });

  factory MenuSizeModel.fromJson(dynamic json)
  => MenuSizeModel(
    id: json["menuSizeId"],
    name: json["name"] ?? "",
    price: (json["price"] as num).toDouble()
  );

}
