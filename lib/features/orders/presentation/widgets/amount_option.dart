import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

class AmountOption extends StatelessWidget {
  final String _title;
  final double _price;
  final int _currentValue;

  const new({
    super.key,
    required this._currentValue,
    required this._title,
    required this._price
  });

  @override
  RadioListTile<int> build(BuildContext context)
  => RadioListTile<int>(
    value: _currentValue,
    contentPadding: const .all(12.0),
    tileColor: Theme.of(context).colorScheme.surface,
    dense: true,
    visualDensity: const VisualDensity(
      horizontal: VisualDensity.minimumDensity,
      vertical: VisualDensity.minimumDensity,
    ),
    materialTapTargetSize: .shrinkWrap,
    minVerticalPadding: 0.0,
    horizontalTitleGap: 4.0,
    title: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            _title,
            style: TextStyles.font14Weight700,
          ),
        ),
        Text(
          "(+ $_price ${context.l10n.pound})",
          style: const TextStyle(
            color: Colors.grey
          ),
        )
      ],
    ),
  );
}