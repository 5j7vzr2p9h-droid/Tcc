import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class DeliveryBottomAppBar extends StatelessWidget {
  final double _total;

  /// Null when picking up from the branch, so only the total is shown.
  final double? _deliveryFee;
  final VoidCallback? _onContinuePressed;

  const new({
    super.key,
    required this._total,
    required this._deliveryFee,
    required this._onContinuePressed
  });

  @override
  Column build(BuildContext context)
  => Column(
    mainAxisSize: .min,
    crossAxisAlignment: .stretch,
    spacing: 16.0,
    children: <Widget>[
      Row(
        spacing: 8.0,
        children: <Widget>[
          Expanded(
            child: Divider(color: Theme.of(context).colorScheme.outline),
          ),
          Icon(
            Icons.delivery_dining,
            color: Theme.of(context).colorScheme.primary
          ),
          Expanded(
            child: Divider(color: Theme.of(context).colorScheme.outline),
          )
        ],
      ),
      Row(
        mainAxisAlignment: .spaceBetween,
        children: <Widget>[
          Text(
            context.l10n.grandTotal,
            style: TextStyles.font14Weight400.copyWith(
              color: Colors.grey
            )
          ),
          Text(
            _deliveryFee == null
              ? "${_total.toStringAsFixed(2)} ${context.l10n.pound}"
              : "${_total.toStringAsFixed(2)} + ${_deliveryFee.toStringAsFixed(2)} ${context.l10n.pound}",
            style: TextStyles.font18Weight700
          )
        ],
      ),
      ElevatedButton(
        onPressed: _onContinuePressed,
        child: Text(context.l10n.continueToPayment)
      )
    ],
  );
}
