import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class NoFavoritesPlaceholder extends StatelessWidget {
  const new({super.key});

  @override
  Center build(BuildContext context)
  => Center(
    child: Column(
      mainAxisAlignment: .center,
      spacing: 12.0,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(25),
          radius: 48.0,
          child: Icon(
            Icons.favorite_outline,
            size: 44.0,
            color: Theme.of(context).colorScheme.primary
          ),
        ),
        Text(
          context.l10n.noFavoritesTitle,
          style: TextStyles.font20Weight700
        ),
        Text(
          context.l10n.noFavoritesMessage,
          textAlign: .center,
          style: TextStyles.font14Weight700.copyWith(color: Colors.grey)
        )
      ],
    ),
  );
}
