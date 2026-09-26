import 'package:hive_flutter/hive_flutter.dart';

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
    required super.price,
    required super.obligatoryAddons,
    required super.optionalAddons,
    required super.sizes,
    required super.addonNote
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
    price: (json["price"] as num).toDouble(),
    obligatoryAddons: (json["configuration"]?["addons"] as List?)
      ?.map<AddonModel>((e) => AddonModel.fromJson(e)).toList() ?? const <AddonModel>[],
    optionalAddons: (json["configuration"]?["conditionalGroups"] as List?)
      ?.expand<AddonModel>((group) => (group?["options"] as List?)
        ?.map<AddonModel>((e) => AddonModel.fromJson(e)) ?? const <AddonModel>[])
      .toList() ?? const <AddonModel>[],
    sizes: (json["configuration"]?["sizes"] as List?)
      ?.map<MenuSizeModel>((e) => MenuSizeModel.fromJson(e)).toList() ?? const <MenuSizeModel>[],
    addonNote: (json["configuration"]?["notes"] as List?)?.firstOrNull?["name"]
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

final class ItemTypeAdapter extends TypeAdapter<ItemModel>{
  @override
  ItemModel read(BinaryReader reader)
  => ItemModel(
    id: reader.readInt(),
    categoryId: reader.readInt(),
    name: reader.readString(),
    image: reader.readString(),
    description: reader.readString(),
    isFeatured: reader.readBool(),
    hasSizes: reader.readBool(),
    price: reader.readDouble(),
    obligatoryAddons: reader.readList().cast<AddonModel>().toList(),
    optionalAddons: reader.readList().cast<AddonModel>().toList(),
    sizes: reader.readList().cast<MenuSizeModel>().toList(),
    addonNote: reader.read() as String?
  );

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, ItemModel obj) {
    writer.writeInt(obj.id);
    writer.writeInt(obj.categoryId);
    writer.writeString(obj.name);
    writer.writeString(obj.image);
    writer.writeString(obj.description);
    writer.writeBool(obj.isFeatured);
    writer.writeBool(obj.hasSizes);
    writer.writeDouble(obj.price);
    writer.writeList(obj.obligatoryAddons);
    writer.writeList(obj.optionalAddons);
    writer.writeList(obj.sizes);
    writer.write(obj.addonNote);
  }
}

final class AddonTypeAdapter extends TypeAdapter<AddonModel>{
  @override
  AddonModel read(BinaryReader reader)
  => AddonModel(
    id: reader.readInt(),
    name: reader.readString(),
    price: reader.readDouble()
  );

  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, AddonModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeDouble(obj.price);
  }
}

final class MenuSizeTypeAdapter extends TypeAdapter<MenuSizeModel>{
  @override
  MenuSizeModel read(BinaryReader reader)
  => MenuSizeModel(
    id: reader.readInt(),
    name: reader.readString(),
    price: reader.readDouble()
  );

  @override
  int get typeId => 3;

  @override
  void write(BinaryWriter writer, MenuSizeModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeDouble(obj.price);
  }
}
