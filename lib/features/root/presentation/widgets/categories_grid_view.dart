import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../domain/entities/category_entity.dart';
import 'category_card.dart';

class CategoriesGridView extends StatelessWidget {
  final List<CategoryEntity> _categories;
  final ValueChanged<int> _onTap;

  const new({
    super.key,
    required this._categories,
    required this._onTap
  });

  @override
  SliverGrid build(BuildContext context)
  => SliverGrid.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: defaultItemsSeparator,
      crossAxisSpacing: defaultItemsSeparator
    ),
    itemCount: _categories.length,
    itemBuilder: (BuildContext context, int i) => CategoryCard(
      title: _categories[i].title,
      image: _categories[i].image,
      onTap: () => _onTap(_categories[i].id),
    )
  );
}