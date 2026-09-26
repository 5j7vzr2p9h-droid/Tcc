import '../../domain/entities/suggested_place_entity.dart';

final class const SuggestedPlaceModel({
  required super.placeId,
  required super.placeTitle
}) extends SuggestedPlaceEntity{

  factory SuggestedPlaceModel.fromJson(dynamic json)
  => SuggestedPlaceModel(
    placeId: json["placeId"],
    placeTitle: json["text"]["text"]
  );
}