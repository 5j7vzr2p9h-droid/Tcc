import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/widgets/search_text_field.dart';
import '../../../../di.dart';
import '../../domain/entities/category_entity.dart';
import '../viewmodels/category_items_viewmodel/category_items_cubit.dart';
import '../viewmodels/search_viewmodel/search_cubit.dart';
import '../viewmodels/search_viewmodel/search_state.dart';
import '../widgets/category_products_view.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/item_wide_card.dart';

final class CategoryProductsPage extends StatefulWidget {
  final List<CategoryEntity> _categories;
  final int _initialCategoryIndex;

  const new({
    super.key,
    required this._categories,
    required this._initialCategoryIndex
  });

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

final class _CategoryProductsPageState extends State<CategoryProductsPage> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void dispose(){
    _searchController.dispose();
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    body: CustomScrollView(
      slivers: <Widget>[
        const DefaultAppBar(
          background: Padding(
            padding: .all(pageContentPadding),
            child: Image(
              image: AssetImage(AssetsManager.logo),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const .symmetric(
              vertical: 12.0,
              horizontal: pageContentPadding,
            ),
            child: ListenableBuilder(
              listenable: _searchController,
              builder: (BuildContext context, Widget? child)
              => SearchTextField(
                controller: _searchController,
                hintText: context.l10n.searchFoodDrinks,
                suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _searchController.clear();
                        context.read<SearchCubit>().cancel();
                      },
                      icon: child!
                    ),
                onChanged: (String value) => value.isEmpty
                  ? context.read<SearchCubit>().cancel()
                  : _debouncer.run(() => context.read<SearchCubit>().search(value))
              ),
              child: const Icon(Icons.close),
            ),
          ),
        ),
        BlocProvider<CategoryProductsCubit>(
          create: (BuildContext _) => getIt<CategoryProductsCubit>()..getCategoryProducts(widget._categories[widget._initialCategoryIndex].id),
          child: BlocConsumer<SearchCubit, SearchState>(
            listener: (BuildContext context, SearchState state){
              if(state is SearchFailureState)
                SnackBarMessage.showErrorMessage(context, state.failure.mapFailureToMessage(context));
            },
            builder: (BuildContext context, SearchState state)
            => state is SearchSuccessState
              ? SliverPadding(
                padding: const .all(pageContentPadding),
                sliver: SliverList.separated(
                  itemCount: state.items.length,
                  separatorBuilder: (BuildContext _, int _) => const SizedBox(height: defaultItemsSeparator),
                  itemBuilder: (BuildContext context, int i) => ItemWideCard(
                    state.items[i]
                  ),
                ),
              )
              : CategoryProductsView(
                categories: widget._categories,
                initialCategoryIndex: widget._initialCategoryIndex,
              ),
          ),
        ),
        const SliverPadding(
          padding: .all(40.0)
        ),
      ],
    ),
  );
}
