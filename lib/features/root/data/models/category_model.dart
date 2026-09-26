import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/category_entity.dart';

final class CategoryModel extends CategoryEntity{
  const new({
    required super.id,
    required super.title,
    required super.image
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json)
  => CategoryModel(
    id: json["id"],
    title: json["title"],
    image: json["image"]
  );
}

final class CategoryTypeAdapter extends TypeAdapter<CategoryModel>{
  @override
  CategoryModel read(BinaryReader reader)
  => CategoryModel(
    id: reader.readInt(),
    title: reader.readString(),
    image: reader.readString()
  );

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.image);
  }
}