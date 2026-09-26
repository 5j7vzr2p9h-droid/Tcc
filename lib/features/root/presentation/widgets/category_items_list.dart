import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/item_entity.dart';
import 'product_of_specified_category.dart';

class CategoryItemsList extends StatelessWidget {
  final String _categoryTitle, _categoryDescription;
  final List<ItemEntity> _products;

  const new({
    super.key,
    required this._categoryTitle,
    required this._categoryDescription,
    required this._products
  });

  @override
  SliverMainAxisGroup build(BuildContext context)
  => SliverMainAxisGroup(
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: .start,
          children: <Widget>[
            Text(
              _categoryTitle,
              style: TextStyles.font20Weight700,
            ),
            Text(
              _categoryDescription,
              style: TextStyle(
                color: Colors.grey.shade600
              ),
            ),
            const SizedBox(height: 8.0)
          ],
        ),
      ),
      SliverList.separated(
        itemCount: _products.length,
        separatorBuilder: (BuildContext _, int _) => const SizedBox(height: defaultItemsSeparator),
        itemBuilder: (BuildContext context, int i) => ProductOfSpecifiedCategory(
          _products[i]
        ),
      )
      
    ]
  );
}