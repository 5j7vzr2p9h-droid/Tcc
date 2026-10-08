import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class const OrderActionButton({
  super.key,
  required final VoidCallback _onPressed
}) extends StatelessWidget {

  @override
  OutlinedButton build(BuildContext context)
  => OutlinedButton.icon(
    onPressed: _onPressed,
    iconAlignment: .end,
    style: OutlinedButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      textStyle: TextStyles.font14Weight700,
      padding: const .symmetric(horizontal: 20.0, vertical: 12.0),
      side: BorderSide(
        color: Theme.of(context).colorScheme.outline
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: .all(.circular(12.0))
      )
    ),
    icon: const Icon(
      Icons.refresh,
      size: 18.0
    ),
    label: Text(context.l10n.reorder)
  );
}
