import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class CouponsInfoCard extends StatelessWidget {
  const new({super.key});

  @override
  Container build(BuildContext context)
  => Container(
    padding: const .all(16.0),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withAlpha(15),
      borderRadius: .circular(12.0)
    ),
    child: Row(
      mainAxisAlignment: .center,
      spacing: 12.0,
      children: <Widget>[
        Icon(
          Icons.info_outline,
          color: Theme.of(context).colorScheme.primary
        ),
        Flexible(
          child: Column(
            spacing: 4.0,
            children: <Text>[
              Text(
                context.l10n.couponsInfoTitle,
                style: TextStyles.font14Weight700
              ),
              Text(
                context.l10n.couponsInfoMessage,
                style: TextStyles.font12Weight400.copyWith(color: Colors.grey)
              )
            ],
          ),
        )
      ],
    ),
  );
}
