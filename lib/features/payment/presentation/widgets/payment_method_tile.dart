import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class PaymentMethodTile extends StatelessWidget {
  final String _title;
  final IconData _icon;
  final bool _selected;
  final VoidCallback _onTap;

  /// Extra content shown under the title, like the wallet balance.
  final Widget? _child;

  const new({
    super.key,
    required this._title,
    required this._selected,
    required this._onTap,
    this._icon = Icons.payments_outlined,
    this._child
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
          SizedBox(
            width: 32.0,
            height: 32.0,
            child: Icon(
              _icon,
              color: Theme.of(context).colorScheme.primary
            )
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 2.0,
              children: <Widget>[
                Text(
                  _title,
                  style: TextStyles.font14Weight700
                ),
                ?_child
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
