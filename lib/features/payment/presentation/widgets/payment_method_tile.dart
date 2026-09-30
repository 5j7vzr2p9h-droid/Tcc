import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/icon_label.dart';
import '../../domain/entities/payment_method_entity.dart';

final class PaymentMethodTile extends StatelessWidget {
  final PaymentMethodEntity _method;
  final bool _selected;
  final VoidCallback _onTap;
  final double? _balance;

  const new({
    super.key,
    required this._method,
    required this._selected,
    required this._onTap,
    this._balance
  });

  @override
  InkWell build(BuildContext context)
  => InkWell(
    onTap: _onTap,
    borderRadius: const .all(.circular(12.0)),
    child: Container(
      padding: const .all(16.0),
      decoration: BoxDecoration(
        color: _selected?
          Theme.of(context).colorScheme.primary.withAlpha(15):
          Theme.of(context).colorScheme.surface,
        borderRadius: .circular(12.0),
        border: .all(
          color: _selected? Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.outline,
          width: _selected? 2.0: 1.0
        )
      ),
      child: Row(
        spacing: 12.0,
        children: <Widget>[
          // Placeholder until each method gets its own image.
          SizedBox(
            width: 32.0,
            height: 32.0,
            child: Icon(
              Icons.payments_outlined,
              color: Theme.of(context).colorScheme.primary
            )
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 2.0,
              children: <Widget>[
                Text(
                  _method.name,
                  style: TextStyles.font14Weight700
                ),
                if(_balance is double)
                  IconLabel(
                    icon: Icons.wallet,
                    color: Theme.of(context).colorScheme.primary,
                    label: "${context.l10n.yourCurrentBalance}: ${_balance.toStringAsFixed(2)} ${context.l10n.pound}"
                  )
              ],
            ),
          ),
          Container(
            width: 22.0,
            height: 22.0,
            padding: const .all(4.0),
            decoration: BoxDecoration(
              shape: .circle,
              color: Theme.of(context).colorScheme.surface,
              border: .all(
                color: _selected? Theme.of(context).colorScheme.primary: Colors.grey,
                width: 2.0
              )
            ),
            child: _selected? DecoratedBox(
              decoration: BoxDecoration(
                shape: .circle,
                color: Theme.of(context).colorScheme.primary
              ),
            ): null
          )
        ],
      ),
    ),
  );
}
