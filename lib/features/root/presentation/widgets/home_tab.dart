import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/widgets/default_circular_indicator.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../../../core/widgets/search_text_field.dart';
import '../../../../splash_page.dart';
import '../../domain/entities/category_entity.dart';
import '../viewmodels/home_viewmodel/home_cubit.dart';
import '../viewmodels/home_viewmodel/home_state.dart';
import 'categories_and_popular.dart';
import 'category_products_view.dart';
import 'default_app_bar.dart';

class HomeTab extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin{
  final ValueNotifier<int?> _choosenCategoryController = ValueNotifier<int?>(null);
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose(){
    _searchController.dispose();
    _choosenCategoryController.dispose();
    super.dispose();
  }

  @override
  BlocBuilder<HomeCubit, HomeState> build(BuildContext context)
  => BlocBuilder<HomeCubit, HomeState>(
    buildWhen: (HomeState previous, HomeState current)
    => current is HomeLoadingState || current is HomeGetFailureState || current is HomeGetSuccessState,
    builder: (BuildContext context, HomeState state)
    => switch(state){
      HomeLoadingState() => const  Center(child: DefaultCircularIndicator()),
      HomeGetFailureState(:final Failure failure) => Center(
        child: FailurePlaceHolder(
          failure: failure,
          onRetry: context.read<HomeCubit>().init
        ),
      ),
      HomeGetSuccessState(:final List<CategoryEntity> categories) => CustomScrollView(
        slivers: <Widget>[
          const SliverPadding(
            padding: .only(
              // top: pageContentPadding,
              // right: pageContentPadding,
              // left: pageContentPadding,
              bottom: 12.0
            ),
            sliver: HomeAppBar(
              imageUrl: "https://www.pngall.com/wp-content/uploads/8/Restaurant-Logo-PNG-Image-HD.png",
              // borderRadiusValue: .circular(16.0),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const .only(
                right: pageContentPadding,
                left: pageContentPadding,
                bottom: 12.0
              ),
              child: SearchTextField(
                controller: _searchController,
                hintText: context.l10n.searchFoodDrinks,
                suffixIcon: const Icon(AppIcons.settings),
              ),
            ),
          ),
          ValueListenableBuilder<int?>(
            valueListenable: _choosenCategoryController,
            builder: (BuildContext context, int? viewCategoryProducts, Widget? child)
            => viewCategoryProducts is int
            ? CategoryProductsView(
              categories: categories,
              initialCategoryIndex: viewCategoryProducts,
            )
            : CategoriesAndPopular(
              onCategoryTap: (int categoryId)
              => _choosenCategoryController.value = categories.indexWhere(
                (CategoryEntity category) => categoryId == category.id
              ),
              categories: categories,
              items: [],
            )
          ),
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: 120.0,
          //     child: ListView.separated(
          //       padding: const .symmetric(
          //         horizontal: pageContentPadding,
          //         // vertical: 100.0
          //       ),
          //       itemCount: 6,
          //       scrollDirection: .horizontal,
          //       separatorBuilder: (BuildContext _, int _) => const SizedBox(width: 4.0),
          //       itemBuilder: (BuildContext context, int i)
          //       => SizedBox(
          //         width: 100.0,
          //         // width: (MediaQuery.widthOf(context) - pageContentPadding*2)/ 4.0 - 4.0,
          //         // available space on screen / no. items to be shown - last separator width
          //         child: CategoryCartoonCard()
          //       ) ,
          //     ),
          //   ),
          // ),
          // SliverPadding(
          //   padding: const .all(pageContentPadding),
          //   sliver: SliverList.separated(
          //     itemCount: 5,
          //     separatorBuilder: (BuildContext context, int i) => const SizedBox(height: 12.0),
          //     itemBuilder: (BuildContext context, int i) => ItemWideCard(
          //       image: "https://pngmagic.com/webp_images/veg-burger-png-image_NXAT.webp",
          //       title: "Cheese Burger",
          //       description: "Bla Bla bla blablablablablabla blablablabla bla",
          //       price: "EGP 120",
          //     ),
          //   ),
          // ),
          const SliverPadding(
            padding: .all(100.0)
          ),
        ],
      ),
      _ => const SizedBox.shrink(),
    }  
  );
}