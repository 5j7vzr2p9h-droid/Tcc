import 'package:flutter/widgets.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/item_entity.dart';
import 'categories_grid_view.dart';
import 'item_card.dart';
import 'title_with_view_all.dart';

class CategoriesAndPopular extends StatelessWidget {
  final ValueChanged<int> _onCategoryTap;
  final List<CategoryEntity> _categories;
  final List<ItemEntity> _items;

  const new({
    super.key,
    required this._onCategoryTap,
    required this._categories,
    required this._items
  });

  @override
  SliverMainAxisGroup build(BuildContext context)
  => SliverMainAxisGroup(
    slivers: <Widget>[
      SliverPadding(
        padding: const .symmetric(
          horizontal: pageContentPadding
        ),
        sliver: CategoriesGridView(
          categories: _categories,
          onTap: _onCategoryTap,
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const .only(
            right: pageContentPadding,
            left: pageContentPadding,
            top: 12.0,
          ),
          child: TitleWithViewAll(
            title: context.l10n.popularItem,
          ),
        ),
      ),
      SliverPadding(
        padding: const .all(24.0),
        sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            mainAxisSpacing: defaultItemsSeparator,
            crossAxisSpacing: defaultItemsSeparator,
          ),
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int i) => ItemCard(
            _items[i]
          )
        ),
      )
    ]
  );
}