import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../domain/entities/favorite_food_entity.dart';
import 'favorite_food_card.dart';
import 'no_favorites_placeholder.dart';

final class FavoriteFoodsTab extends StatelessWidget {
  const new({super.key});

  static const List<FavoriteFoodEntity> _foods = <FavoriteFoodEntity>[
    FavoriteFoodEntity(
      name: "كريب تشيكن رانش",
      description: "دجاج كريسبي، جبنة شيدر، رانش، خس طازج",
      image: "https://i.pinimg.com/originals/4a/18/ee/4a18ee8e42ee9bf9cedb44a5519ddbda.jpg",
      price: 110.0
    ),
    FavoriteFoodEntity(
      name: "كريب سوبر تكساس",
      description: "لحمة، مشروم، فلفل ألوان، صوص تكساس، موتزاريلا",
      image: "https://i.pinimg.com/originals/4a/18/ee/4a18ee8e42ee9bf9cedb44a5519ddbda.jpg",
      price: 125.0
    ),
    FavoriteFoodEntity(
      name: "بطاطس فرايز",
      description: "بطاطس مقرمشة ذهبية",
      image: "https://i.pinimg.com/originals/4a/18/ee/4a18ee8e42ee9bf9cedb44a5519ddbda.jpg",
      price: 45.0
    ),
    FavoriteFoodEntity(
      name: "بيبسي",
      description: "330 مل",
      image: "https://i.pinimg.com/originals/4a/18/ee/4a18ee8e42ee9bf9cedb44a5519ddbda.jpg",
      price: 20.0
    )
  ];

  @override
  Widget build(BuildContext context) {
    if(_foods.isEmpty) return const Padding(
      padding: .all(pageContentPadding),
      child: NoFavoritesPlaceholder(),
    );

    return ListView.separated(
      padding: const .all(pageContentPadding),
      physics: const BouncingScrollPhysics(),
      itemCount: _foods.length,
      separatorBuilder: (BuildContext context, int _) => const SizedBox(height: defaultItemsSeparator),
      itemBuilder: (BuildContext context, int i) => FavoriteFoodCard(
        food: _foods[i],
        onTap: (){},
        onDeletePressed: (){},
      ),
    );
  }
}
