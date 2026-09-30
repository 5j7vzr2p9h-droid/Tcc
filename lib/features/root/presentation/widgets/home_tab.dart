import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../../../core/widgets/search_text_field.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/item_entity.dart';
import '../viewmodels/home_viewmodel/home_cubit.dart';
import '../viewmodels/home_viewmodel/home_state.dart';
import '../viewmodels/search_viewmodel/search_cubit.dart';
import '../viewmodels/search_viewmodel/search_state.dart';
import 'banners_slider.dart';
import 'categories_and_popular.dart';
import 'default_app_bar.dart';
import 'item_wide_card.dart';

class HomeTab extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>{
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void dispose(){
    _searchController.dispose();
    _debouncer.cancel();
    super.dispose();
  }

  @override
  BlocBuilder<HomeCubit, HomeState> build(BuildContext context)
  => BlocBuilder<HomeCubit, HomeState>(
    buildWhen: (HomeState previous, HomeState current)
    => current is HomeLoadingState || current is HomeGetFailureState || current is HomeGetSuccessState,
    builder: (BuildContext context, HomeState state)
    => switch(state){
      HomeLoadingState() => const  Center(child: CircularProgressIndicator()),
      HomeGetFailureState(:final Failure failure) => Center(
        child: FailurePlaceHolder(
          failure: failure,
          onRetry: context.read<HomeCubit>().init
        ),
      ),
      HomeGetSuccessState(:final List<CategoryEntity> categories, :final List<ItemEntity> popularItems)
      => CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const .only(bottom: 12.0),
            sliver: DefaultAppBar(
              background: const BannersSlider(
                <String>[
                  "https://ichef.bbci.co.uk/food/ic/food_16x9_1600/recipes/roastchicken_90247_16x9.jpg",
                  "https://images.squarespace-cdn.com/content/v1/57879a6cbebafb879f256735/94b1c4ee-189a-4a42-92f3-ea988684da5c/KK050424-2_original_uxga.jpg?format=750w",
                  "https://images.squarespace-cdn.com/content/v1/57879a6cbebafb879f256735/df556634-af33-4d87-8f45-423550cdefae/ARM050424-38_original_uxga.jpg?format=750w"
                ]
              ),
              leading: IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).colorScheme.onPrimary,
                )
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const .only(
                right: pageContentPadding,
                left: pageContentPadding,
                bottom: 12.0
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
                  onChanged: (String value) => _debouncer.run(() => context.read<SearchCubit>().search(value)),
                ),
                child: const Icon(Icons.close),
              ),
            ),
          ),
          BlocConsumer<SearchCubit, SearchState>(
            listener: (BuildContext context, SearchState state){
              if(state is SearchFailureState)
                SnackBarMessage.showErrorMessage(context, state.failure.mapFailureToMessage(context));
            },
            builder: (BuildContext context, SearchState state)
            => state is SearchSuccessState
              ? SliverList.separated(
                itemCount: state.items.length,
                separatorBuilder: (BuildContext _, int _) => const SizedBox(height: defaultItemsSeparator),
                itemBuilder: (BuildContext context, int i) => ItemWideCard(
                  state.items[i]
                ),
              )
              : CategoriesAndPopular(
                onCategoryTap: (int categoryId) => Navigator.pushNamed(
                  context,
                  Routes.categoryProducts,
                  arguments: (
                    categories,
                    categories.indexWhere((CategoryEntity category) => categoryId == category.id)
                  )
                ),
                categories: categories,
                items: popularItems,
              )
          ),
          const SliverPadding(
            padding: .all(40.0)
          ),
        ],
      ),
      HomeInitialState() => const SizedBox.shrink(),
    }  
  );
}