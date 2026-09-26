import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class NotificationFilterChip extends StatelessWidget {
  final String _label;
  final bool _selected;
  final VoidCallback _onPressed;

  const new({
    super.key,
    required this._label,
    required this._selected,
    required this._onPressed
  });

  @override
  InkWell build(BuildContext context)
  => InkWell(
    onTap: _onPressed,
    customBorder: const StadiumBorder(),
    child: Container(
      padding: const .symmetric(
        horizontal: 20.0,
        vertical: 10.0
      ),
      decoration: ShapeDecoration(
        color: _selected?
          Theme.of(context).colorScheme.primary:
          Theme.of(context).colorScheme.surface,
        shape: StadiumBorder(
          side: BorderSide(
            color: _selected?
              Theme.of(context).colorScheme.primary:
              Theme.of(context).colorScheme.outline
          )
        )
      ),
      child: Text(
        _label,
        style: TextStyles.font14Weight700.copyWith(
          color: _selected?
            Theme.of(context).colorScheme.onPrimary:
            Theme.of(context).colorScheme.onSurface
        ),
      ),
    ),
  );
}
