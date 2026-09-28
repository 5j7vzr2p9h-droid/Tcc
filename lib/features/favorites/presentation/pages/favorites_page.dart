import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../../../di.dart';
import '../../../root/domain/entities/item_entity.dart';
import '../viewmodel/favorites_viewmodel/favorites_cubit.dart';
import '../viewmodel/favorites_viewmodel/favorites_state.dart';
import '../widgets/favorite_item_card.dart';

final class FavoritesPage extends StatelessWidget {
  const new({super.key});

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(context.l10n.favorites),
    ),
    body: BlocProvider<FavoritesCubit>(
      create: (BuildContext context) => getIt<FavoritesCubit>()..init(),
      child: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (BuildContext context, FavoritesState state)
        => switch(state){
          FavroitesInitialState() => const SizedBox.shrink(),
          FavoritesLoadingState() => const Center(child: CircularProgressIndicator()),
          FavoritesGetFailureState(:final Failure failure) => Center(child: FailurePlaceHolder(
            failure: failure,
            onRetry: context.read<FavoritesCubit>().init,
          )),
          FavoritesGetSuccessState(:final List<ItemEntity> favorites) => favorites.isEmpty
            ? Center(
              child: EmptyDataPlaceholder(
                iconData: Icons.favorite_outline_outlined,
                title: context.l10n.noFavoritesTitle,
                description: context.l10n.noFavoritesMessage
              ),
            )
            : ListView.separated(
              padding: const .all(pageContentPadding),
              physics: const BouncingScrollPhysics(),
              itemCount: favorites.length,
              separatorBuilder: (BuildContext context, int _) => const SizedBox(height: defaultItemsSeparator),
              itemBuilder: (BuildContext context, int i) => FavoriteItemCard(
                product: favorites[i],
                onTap: (){},
                onRemoved: () => context.read<FavoritesCubit>().removeFavorite(favorites[i].id),
              ),
            ),
        },
      ),
    )
  );
}
