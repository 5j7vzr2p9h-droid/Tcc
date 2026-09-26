import 'package:flutter/material.dart';

import '../extensions/context_l10n.dart';
import '../utils/text_styles.dart';

final class DefaultBadge extends StatelessWidget {
  const new({super.key});

  @override
  Container build(BuildContext context)
  => Container(
    padding: const .symmetric(
      horizontal: 12.0,
      vertical: 4.0
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withAlpha(25),
      borderRadius: .circular(8.0)
    ),
    child: Text(
      context.l10n.defaultLabel,
      style: TextStyles.font12Weight700.copyWith(
        color: Theme.of(context).colorScheme.primary
      )
    ),
  );
}
