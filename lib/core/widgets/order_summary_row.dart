import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

final class OrderSummaryRow extends StatelessWidget {
  final String _label, _value;
  final bool _isTotal;
  final Color? _valueColor;

  const new({
    super.key,
    required this._label,
    required this._value,
    this._isTotal = false,
    this._valueColor
  });

  @override
  Row build(BuildContext context)
  => Row(
    mainAxisAlignment: .spaceBetween,
    children: <Widget>[
      Text(
        _label,
        style: _isTotal? TextStyles.font14Weight700: TextStyles.font14Weight400
      ),
      Text(
        _value,
        style: (_isTotal? TextStyles.font18Weight700: TextStyles.font14Weight700).copyWith(
          color: _valueColor ?? (_isTotal? Theme.of(context).colorScheme.primary: null)
        )
      )
    ],
  );
}
