import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';

final class CouponCodeField extends StatelessWidget {
  final TextEditingController _controller;
  final VoidCallback _onApplyPressed;

  const new({
    super.key,
    required this._controller,
    required this._onApplyPressed
  });

  @override
  Container build(BuildContext context)
  => Container(
    padding: const .all(8.0),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: .circular(16.0),
      border: .all(
        color: Theme.of(context).colorScheme.outline
      )
    ),
    child: Row(
      spacing: 8.0,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha(25),
            borderRadius: const .all(.circular(12.0))
          ),
          child: Icon(
            Icons.discount,
            color: Theme.of(context).colorScheme.primary
          ),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            textAlign: .center,
            textInputAction: .done,
            maxLength: 12,
            decoration: InputDecoration(
              counterText: '',
              filled: false,
              hintText: context.l10n.enterCouponCode,
              border: .none,
              enabledBorder: .none,
              focusedBorder: .none,
            ),
          ),
        ),
        SizedBox(
          width: 90.0,
          height: 36.0,
          child: ElevatedButton(
            onPressed: _onApplyPressed,
            child: Text(context.l10n.apply)
          ),
        )
      ],
    ),
  );
}