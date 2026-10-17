import 'package:flutter/material.dart';

import '../extensions/context_l10n.dart';
import 'order_summary_row.dart';

final class OrderSummaryField extends StatelessWidget {
  final double _itemsTotal, _discount;
  final double?  _deliveryFee;

  const new({
    super.key,
    required this._itemsTotal,
    this._deliveryFee,
    this._discount = 0.0
  });

  double get _total => _itemsTotal + (_deliveryFee ?? 0.0) - _discount;

  @override
  Container build(BuildContext context)
  => Container(
    padding: const .all(16.0),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: .circular(8.0),
      border: .all(
        color: Theme.of(context).colorScheme.outline
      ),
    ),
    child: Column(
      spacing: 8.0,
      children: <Widget>[
        OrderSummaryRow(
          label: context.l10n.productsSubtotal,
          value: "${_itemsTotal.toStringAsFixed(0)} ${context.l10n.pound}"
        ),
        OrderSummaryRow(
          label: context.l10n.deliveryFee,
          value: _deliveryFee is double
            ? "${_deliveryFee.toStringAsFixed(0)} ${context.l10n.pound}"
            : context.l10n.notCalculatedYet
        ),
        OrderSummaryRow(
          label: context.l10n.discount,
          value: "-${_discount.toStringAsFixed(0)} ${context.l10n.pound}",
          valueColor: Colors.green
        ),
        if(_deliveryFee is double)
          ...[
            Divider(color: Theme.of(context).colorScheme.outline),
            OrderSummaryRow(
              label: context.l10n.grandTotal,
              value: "${_total.toStringAsFixed(0)} ${context.l10n.pound}",
              isTotal: true
            )
          ]
      ],
    ),
  );
}
