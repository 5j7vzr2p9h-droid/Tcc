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