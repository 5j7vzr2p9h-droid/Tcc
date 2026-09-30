import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../domain/entities/category_entity.dart';
import '../widgets/category_products_view.dart';
import '../widgets/default_app_bar.dart';

final class CategoryProductsPage extends StatelessWidget {
  final List<CategoryEntity> _categories;
  final int _initialCategoryIndex;

  const new({
    super.key,
    required this._categories,
    required this._initialCategoryIndex
  });

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    body: CustomScrollView(
      slivers: <Widget>[
        const SliverPadding(
          padding: .only(bottom: 12.0),
          sliver: DefaultAppBar(
            background: Padding(
              padding: .all(pageContentPadding),
              child: Image(
                image: AssetImage(AssetsManager.logo),
              ),
            ),
          ),
        ),
        CategoryProductsView(
          categories: _categories,
          initialCategoryIndex: _initialCategoryIndex,
        ),
        const SliverPadding(
          padding: .all(40.0)
        ),
      ],
    ),
  );
}
