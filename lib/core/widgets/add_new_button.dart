import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

final class AddNewButton extends StatelessWidget {
  static const double _borderRadiusValue = 8.0;
  final String _label;
  final VoidCallback _onPressed;

  const new({
    super.key,
    required this._label,
    required this._onPressed
  });

  @override
  InkWell build(BuildContext context)
  => InkWell(
    onTap: _onPressed,
    borderRadius: .circular(_borderRadiusValue),
    child: DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: const .circular(_borderRadiusValue),
        padding: const .all(12.0),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(
        child: Row(
          mainAxisSize: .min,
          spacing: 8.0,
          children: <Widget>[
            Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
            Text(
              _label,
              style: TextStyles.font14Weight700.copyWith(
                color: Theme.of(context).colorScheme.primary
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
