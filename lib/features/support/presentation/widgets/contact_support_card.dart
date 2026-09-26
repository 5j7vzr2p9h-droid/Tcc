import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/text_styles.dart';

final class ContactSupportCard extends StatelessWidget {
  final VoidCallback _onChatPressed;

  const new({
    super.key,
    required this._onChatPressed
  });

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
        SvgPicture.asset(
          AssetsManager.chat,
          width: 72.0
        ),
        Expanded(
          child: Column(
            spacing: 8.0,
            children: <Widget>[
              Text(
                context.l10n.contactUs,
                style: TextStyles.font18Weight700
              ),
              Text(
                context.l10n.contactUsMessage,
                style: TextStyles.font12Weight400.copyWith(color: Colors.grey)
              ),
              ElevatedButton.icon(
                onPressed: _onChatPressed,
                icon: const Icon(Icons.chat_bubble_outline),
                label: Text(context.l10n.chatWithSupport)
              ),
              Text(
                context.l10n.supportHours,
                textAlign: .center,
                style: TextStyles.font12Weight400.copyWith(color: Colors.grey)
              )
            ],
          ),
        ),
      ],
    ),
  );
}