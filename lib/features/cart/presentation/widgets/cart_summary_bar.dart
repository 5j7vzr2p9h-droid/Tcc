import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/handled_network_image.dart';
import '../viewmodel/cart_cubit.dart';
import '../viewmodel/cart_state.dart';

/// Shows the current cart, and hides itself while the cart is empty.
final class CartSummaryBar extends StatelessWidget {
  final VoidCallback _onTap;

  const new({
    super.key,
    required this._onTap
  });

  @override
  BlocBuilder<CartCubit, CartState> build(BuildContext context)
  => BlocBuilder<CartCubit, CartState>(
    builder: (BuildContext context, CartState state)
    => state.isEmpty
    ? const SizedBox.shrink()
    : InkWell(
      onTap: _onTap,
      borderRadius: .circular(16.0),
      child: Container(
        padding: const .symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: .circular(16.0)
        ),
        child: Row(
          spacing: 8.0,
          children: <Widget>[
            Stack(
              clipBehavior: .none,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const .all(.circular(10.0)),
                  child: HandledNetworkImage(
                    imageUrl: state.items.last.image,
                    width: 36.0,
                    height: 36.0,
                  ),
                ),
                Positioned(
                  top: -6.0,
                  right: -6.0,
                  child: CircleAvatar(
                    radius: 8.0,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    child: Text(
                      "${state.itemsCount}",
                      style: TextStyles.font12Weight700.copyWith(
                        color: Theme.of(context).colorScheme.onSurface
                      )
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: <Widget>[
                  Text(
                    context.l10n.viewCart,
                    style: TextStyles.font14Weight700.copyWith(color: Colors.white)
                  ),
                  Text(
                    "${state.itemsCount} ${context.l10n.product}",
                    style: TextStyles.font12Weight400.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary
                    )
                  )
                ],
              ),
            ),
            Text(
              "${state.subtotal.toStringAsFixed(2)} ${context.l10n.pound}",
              style: TextStyles.font14Weight700.copyWith(color: Colors.white)
            ),
            const Icon(Icons.chevron_right, color: Colors.white, size: 20.0)
          ],
        ),
      ),
    ),
  );
}
