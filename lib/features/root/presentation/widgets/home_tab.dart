import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/item_entity.dart';
import '../viewmodels/home_viewmodel/home_cubit.dart';
import '../viewmodels/home_viewmodel/home_state.dart';
import 'banners_slider.dart';
import 'categories_and_popular.dart';
import 'default_app_bar.dart';

class HomeTab extends StatelessWidget {
  const new({super.key});

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
              hasBackButton: false,
            ),
          ),
          CategoriesAndPopular(
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