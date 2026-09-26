import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import 'category_wide_card.dart';

class CategoriesListView extends StatelessWidget {
  const new({super.key});

  @override
  SliverList build(BuildContext context)
  => SliverList.separated(
    itemCount: 4,
    separatorBuilder: (BuildContext _, int _) => const SizedBox(height: defaultItemsSeparator),
    itemBuilder: (BuildContext context, int i) => CategoryWideCard(
      title: "burgers",
      image: "https://img.magnific.com/premium-photo/all-fast-food-collection-set-isolated-white-background-fried-chicken-fries-hamburger-turkey-hotdog-sandwich-chicken-nuggets-shawarma-junk-food-fast-food-set-closeup-fast-foods_1028938-188364.jpg?w=2000",
    ),
  );
}