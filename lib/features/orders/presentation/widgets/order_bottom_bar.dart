import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/quantity_stepper.dart';
import '../../../cart/presentation/widgets/cart_summary_bar.dart';

final class OrderBottomBar extends StatelessWidget {
  final ValueNotifier<int> _quantityController;
  final VoidCallback _onAddToOrder;
  final double _totalPrice;
  final VoidCallback _onViewCart;

  const new({
    super.key,
    required this._quantityController,
    required this._onAddToOrder,
    required this._totalPrice,
    required this._onViewCart
  });

  @override
  Container build(BuildContext context)
  => Container(
    padding: const .only(
      left: pageContentPadding,
      right: pageContentPadding,
      top: 12.0,
      bottom: 12.0
    ),
    color: Theme.of(context).colorScheme.surface,
    child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: .min,
        spacing: 8.0,
        children: <Widget>[
          Text(
            context.l10n.chooseQuantityToAdd,
            style: TextStyles.font12Weight400.copyWith(color: Colors.grey),
            textAlign: .center,
          ),
          Row(
            spacing: 8.0,
            children: <Widget>[
              QuantityStepper(controller: _quantityController),
              Expanded(
                child: ElevatedButton(
                  onPressed: _onAddToOrder,
                  child: Text("${context.l10n.addToOrder} • ${_totalPrice.toStringAsFixed(2)} ${context.l10n.pound}"),
                ),
              )
            ],
          ),
          CartSummaryBar(
            onTap: _onViewCart,
          )
        ],
      ),
    ),
  );
}
