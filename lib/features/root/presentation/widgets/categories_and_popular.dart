import 'package:flutter/widgets.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/item_entity.dart';
import 'categories_grid_view.dart';
import 'item_card.dart';

final class CategoriesAndPopular extends StatelessWidget {
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
          child: Text(
            context.l10n.popularItem,
            style: TextStyles.font20Weight700,
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 240.0,
          child: ListView.separated(
            padding: const .all(pageContentPadding),
            scrollDirection: .horizontal,
            itemCount: _items.length,
            separatorBuilder: (BuildContext _, int _) => const SizedBox(width: defaultItemsSeparator),
            itemBuilder: (BuildContext context, int i) => ItemCard(
              _items[i]
            )
          ),
        ),
      )
    ]
  );
}