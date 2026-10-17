import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class const WalletBalanceCard({
  super.key,
  required final double _balance
}) extends StatelessWidget {

  @override
  Container build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary,
      onPrimary = Theme.of(context).colorScheme.onPrimary;

    return Container(
      padding: const .all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            primary,
            Color.lerp(primary, Colors.black, 0.3)!
          ],
          begin: .topLeft,
          end: .bottomRight
        ),
        borderRadius: const .all(.circular(16.0))
      ),
      child: Row(
        spacing: 16.0,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 8.0,
              children: <Widget>[
                Text(
                  context.l10n.walletBalance,
                  style: TextStyles.font14Weight700.copyWith(
                    color: onPrimary.withAlpha(220)
                  )
                ),
                FittedBox(
                  fit: .scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: NumberFormat.decimalPattern(context.l10n.localeName).format(_balance),
                          style: TextStyles.font32Weight900
                        ),
                        TextSpan(
                          text: " ${context.l10n.pound}",
                          style: TextStyles.font18Weight700
                        )
                      ]
                    ),
                    style: TextStyle(color: onPrimary)
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 64.0,
            child: VerticalDivider(
              width: 1.0,
              color: onPrimary.withAlpha(60)
            ),
          ),
          CircleAvatar(
            radius: 32.0,
            backgroundColor: onPrimary.withAlpha(40),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              size: 32.0,
              color: onPrimary
            ),
          )
        ],
      ),
    );
  }
}
