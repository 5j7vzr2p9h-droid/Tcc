import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../cart/presentation/viewmodel/cart_cubit.dart';
import '../../../cart/presentation/viewmodel/cart_state.dart';
import '../../../cart/presentation/widgets/cart_item_card.dart';

final class CartStep extends StatelessWidget {
  const new({super.key});

  @override
  BlocConsumer<CartCubit, CartState> build(BuildContext context)
  => BlocConsumer<CartCubit, CartState>(
    listener: (BuildContext context, CartState state){
      if(state is CartFailureState)
        SnackBarMessage.showErrorMessage(
          context,
          state.failure.mapFailureToMessage(context)
        );
    },
    builder: (BuildContext context, CartState state)
    => state.isEmpty
    ? SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: EmptyDataPlaceholder(
          iconData: Icons.shopping_cart_outlined,
          title: context.l10n.emptyCartTitle,
          description: context.l10n.emptyCartMessage
        ),
      ),
    )
    : SliverPadding(
      padding: const .all(pageContentPadding),
      sliver: SliverList.separated(
        itemCount: state.items.length,
        separatorBuilder: (BuildContext _, int _) => const SizedBox(height: defaultItemsSeparator),
        itemBuilder: (BuildContext context, int i){
          final CartItemEntity item = state.items[i];
          return CartItemCard(
            key: ValueKey<String>(item.key),
            item: item,
            onQuantityChanged: (int quantity) => context.read<CartCubit>().updateQuantity(item.key, quantity),
            onDeletePressed: () => context.read<CartCubit>().removeFromCart(item.key),
          );
        },
      ),
    ),
  );
}
