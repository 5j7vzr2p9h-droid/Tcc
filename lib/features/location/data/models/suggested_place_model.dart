import '../../../delivery/domain/entities/suggested_place_entity.dart';

final class SuggestedPlaceModel extends SuggestedPlaceEntity{
  new({required super.placeId, required super.placeTitle});

  factory SuggestedPlaceModel.fromJson(dynamic json)
  => SuggestedPlaceModel(
    placeId: json["placeId"],
    placeTitle: json["text"]["text"]
  );
}