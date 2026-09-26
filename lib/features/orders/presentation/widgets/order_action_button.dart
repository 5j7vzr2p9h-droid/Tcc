import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class OrderActionButton extends StatelessWidget {
  final bool _isTracking;
  final VoidCallback _onPressed;

  const new({
    super.key,
    required this._isTracking,
    required this._onPressed
  });

  @override
  OutlinedButton build(BuildContext context)
  => OutlinedButton.icon(
    onPressed: _onPressed,
    iconAlignment: .end,
    style: OutlinedButton.styleFrom(
      foregroundColor: _isTracking?
        Theme.of(context).colorScheme.error:
        Theme.of(context).colorScheme.onSurface,
      backgroundColor: Theme.of(context).colorScheme.surface,
      textStyle: TextStyles.font14Weight700,
      padding: const .symmetric(horizontal: 20.0, vertical: 12.0),
      side: BorderSide(
        color: _isTracking?
          Theme.of(context).colorScheme.error:
          Theme.of(context).colorScheme.outline
      ),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12.0)
      )
    ),
    icon: Icon(
      _isTracking? Icons.location_searching: Icons.refresh,
      size: 18.0
    ),
    label: Text(_isTracking? context.l10n.trackOrder: context.l10n.reorder)
  );
}
