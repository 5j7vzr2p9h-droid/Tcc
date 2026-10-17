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
      HomeGetSuccessState(
        :final List<String> banners,
        :final List<CategoryEntity> categories,
        :final List<ItemEntity> popularItems
      )
      => CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const .only(bottom: 12.0),
            sliver: DefaultAppBar(
              background: BannersSlider(banners),
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