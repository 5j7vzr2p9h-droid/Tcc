import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/category_entity.dart';
import '../viewmodels/category_items_viewmodel/category_items_cubit.dart';

final class CategoriesTabBar extends StatelessWidget {
  final List<CategoryEntity> _categories;
  final TabController _tabController;

  const new({
    super.key,
    required this._categories,
    required this._tabController
  });

  @override
  TabBar build(BuildContext context)
  => TabBar(
    isScrollable: true,
    controller: _tabController,
    labelStyle: TextStyles.font18Weight700,
    labelColor: Theme.of(context).colorScheme.onSurface,
    indicatorColor: Theme.of(context).colorScheme.onSurface,
    unselectedLabelColor: Colors.grey,
    dividerColor: Colors.grey.shade300,
    splashBorderRadius: const .all(.circular(8.0)),
    onTap: (int i) {
      _tabController.index = i;
      context.read<CategoryProductsCubit>().getCategoryProducts(_categories[i].id);
    },
    tabAlignment: .center,
    tabs: <Text>[
      for(CategoryEntity category in _categories)
        Text(category.title),
    ]
      
  );
}