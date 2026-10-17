import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class const TopUpBalanceButton({
  super.key,
  required final VoidCallback _onTap
}) extends StatelessWidget {

  @override
  InkWell build(BuildContext context)
  => InkWell(
    onTap: _onTap,
    borderRadius: const .all(.circular(12.0)),
    child: Container(
      padding: const .all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(15),
        borderRadius: .circular(12.0),
        border: .all(
          color: Theme.of(context).colorScheme.primary.withAlpha(60)
        )
      ),
      child: Row(
        spacing: 12.0,
        children: <Widget>[
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onPrimary
            ),
          ),
          Expanded(
            child: Text(
              context.l10n.topUpBalance,
              style: TextStyles.font16Weight700
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16.0,
            color: Theme.of(context).colorScheme.primary
          )
        ],
      ),
    ),
  );
}
