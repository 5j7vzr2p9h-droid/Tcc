import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../di.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/item_entity.dart';
import '../viewmodels/category_items_viewmodel/category_items_cubit.dart';
import '../viewmodels/category_items_viewmodel/category_items_state.dart';
import 'categories_tab_bar.dart';
import 'category_items_list.dart';

final class CategoryProductsView extends StatefulWidget {
  final List<CategoryEntity> _categories;
  final int _initialCategoryIndex;

  const new({
    super.key,
    required this._categories,
    required this._initialCategoryIndex
  });

  @override
  State<CategoryProductsView> createState() => _CategoryProductsViewState();
}

final class _CategoryProductsViewState extends State<CategoryProductsView> with SingleTickerProviderStateMixin{
  late final TabController _tabController = TabController(
    length: widget._categories.length,
    initialIndex: widget._initialCategoryIndex,
    vsync: this
  );

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  @override
  BlocProvider<CategoryProductsCubit> build(BuildContext context)
  => BlocProvider<CategoryProductsCubit>(
    create: (BuildContext _) => getIt<CategoryProductsCubit>()..getCategoryProducts(widget._categories[widget._initialCategoryIndex].id),
    child: SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: CategoriesTabBar(
            tabController: _tabController,
            categories: widget._categories,
          ),
        ),
        BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
          builder: (BuildContext context, CategoryProductsState state)
          => switch(state){
              CategoryProductsGetSuccessState(:final List<ItemEntity> products) => SliverPadding(
                padding: const .all(pageContentPadding),
                sliver: CategoryItemsList(
                  categoryTitle: widget._categories[_tabController.index].title,
                  categoryDescription: "da asdsa dasds dsasad", // Need From BACKENDDDDDDDD
                  products: products
                ),
              ),
              CategoryProductsGetFailureState(:final Failure failure) => SliverToBoxAdapter(
                child: Text(failure.mapFailureToMessage(context)),
              ),
              CategoryProductsLoadingState() => const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator())
              ),
              _ => const SliverPadding(padding: .zero)
            }
        ),
      ],
    ),
  );
}