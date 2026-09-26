import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class DeliveryBottomAppBar extends StatelessWidget {
  final double _total;
  final VoidCallback _onContinuePressed;

  const new({
    super.key,
    required this._total,
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
            "${_total.toStringAsFixed(2)} ${context.l10n.pound}",
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
