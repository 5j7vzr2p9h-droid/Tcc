import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class const RecentTransactionsHeader({
  super.key,
  required final VoidCallback _onViewAll
}) extends StatelessWidget {

  @override
  Row build(BuildContext context)
  => Row(
    spacing: 8.0,
    children: <Widget>[
      const Icon(Icons.history),
      Expanded(
        child: Text(
          context.l10n.recentTransactions,
          style: TextStyles.font18Weight700
        ),
      ),
      TextButton.icon(
        onPressed: _onViewAll,
        iconAlignment: .end,
        style: TextButton.styleFrom(
          padding: .zero,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity
          )
        ),
        icon: const Icon(Icons.arrow_forward_ios, size: 14.0),
        label: Text(context.l10n.viewAll)
      )
    ],
  );
}
