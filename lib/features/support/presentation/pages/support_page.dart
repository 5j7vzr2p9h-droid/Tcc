import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../widgets/contact_support_card.dart';
import '../widgets/support_hero_card.dart';
import '../widgets/support_topic_group.dart';
import '../widgets/support_topic_tile.dart';

final class SupportPage extends StatelessWidget {
  const new({super.key});

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      title: Text(context.l10n.support, style: TextStyles.font18Weight700),
      centerTitle: true,
      actions: <IconButton>[
        IconButton(
          onPressed: (){},
          icon: const Icon(Icons.chat_bubble_outline)
        )
      ],
    ),
    body: ListView(
      padding: const .all(pageContentPadding),
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        const SupportHeroCard(),
        const SizedBox(height: 24.0),
        SupportTopicGroup(
          icon: Icons.inventory_2_outlined,
          title: context.l10n.orderIssue,
          tiles: <SupportTopicTile>[
            SupportTopicTile(
              icon: Icons.assignment_outlined,
              title: context.l10n.followOrder,
              onTap: (){},
            ),
            SupportTopicTile(
              icon: Icons.access_time,
              title: context.l10n.lateOrder,
              onTap: (){},
            ),
            SupportTopicTile(
              icon: Icons.remove_shopping_cart_outlined,
              title: context.l10n.wrongOrMissingItem,
              onTap: (){},
            )
          ],
        ),
        const SizedBox(height: defaultItemsSeparator),
        SupportTopicGroup(
          icon: Icons.account_balance_wallet_outlined,
          title: context.l10n.payment,
          tiles: <SupportTopicTile>[
            SupportTopicTile(
              icon: Icons.credit_card,
              title: context.l10n.paymentIssue,
              onTap: (){},
            ),
            SupportTopicTile(
              icon: Icons.history,
              title: context.l10n.paymentNotConfirmed,
              onTap: (){},
            ),
            SupportTopicTile(
              icon: Icons.currency_exchange,
              title: context.l10n.refund,
              onTap: (){},
            )
          ],
        ),
        const SizedBox(height: defaultItemsSeparator),
        SupportTopicGroup(
          icon: Icons.person_outline,
          title: context.l10n.account,
          tiles: <SupportTopicTile>[
            SupportTopicTile(
              icon: Icons.manage_accounts_outlined,
              title: context.l10n.editAccountData,
              onTap: (){},
            ),
            SupportTopicTile(
              icon: Icons.lock_outline,
              title: context.l10n.loginIssue,
              onTap: (){},
            )
          ],
        ),
        const SizedBox(height: 24.0),
        ContactSupportCard(
          onChatPressed: (){},
        )
      ],
    ),
  );
}
