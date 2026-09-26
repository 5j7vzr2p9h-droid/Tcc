import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/text_styles.dart';

final class PrivacyHeroCard extends StatelessWidget {
  const new({super.key});

  @override
  Container build(BuildContext context)
  => Container(
    padding: const .all(16.0),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withAlpha(15),
      borderRadius: .circular(16.0)
    ),
    child: Row(
      spacing: 16.0,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 8.0,
            children: <Text>[
              Text(
                context.l10n.privacyHeroTitle,
                style: TextStyles.font20Weight700
              ),
              Text(
                context.l10n.privacyHeroMessage,
                style: TextStyles.font12Weight700.copyWith(color: Colors.grey)
              )
            ],
          ),
        ),
        SvgPicture.asset(
          AssetsManager.security,
          width: 96.0,
        )
      ],
    ),
  );
}
