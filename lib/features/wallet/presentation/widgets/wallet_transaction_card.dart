import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/wallet_transaction_entity.dart';

final class const WalletTransactionCard({
  super.key,
  required final WalletTransactionEntity _transaction
}) extends StatelessWidget {

  IconData get _icon => switch(_transaction.type){
    .payment => Icons.credit_card,
    .topUp => Icons.account_balance_wallet_outlined,
    .refund => Icons.replay
  };

  String _getTitle(BuildContext context) => switch(_transaction.type){
    .payment => context.l10n.walletPaymentTransaction,
    .topUp => context.l10n.walletTopUpTransaction,
    .refund => context.l10n.walletRefundTransaction
  };

  @override
  Container build(BuildContext context) {
    final Color statusColor = _transaction.isSuccessful
      ? Theme.of(context).colorScheme.primary
      : Theme.of(context).colorScheme.error;
    final Color amountColor = _transaction.isSuccessful && _transaction.type.isCredit
      ? Theme.of(context).colorScheme.primary
      : Theme.of(context).colorScheme.error;

    return Container(
      padding: const .all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: .circular(16.0),
        border: .all(
          color: Theme.of(context).colorScheme.outline
        )
      ),
      child: Row(
        spacing: 12.0,
        children: <Widget>[
          CircleAvatar(
            radius: 24.0,
            backgroundColor: statusColor.withAlpha(25),
            child: Icon(_icon, color: statusColor),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 4.0,
              children: <Widget>[
                Row(
                  spacing: 4.0,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        _getTitle(context),
                        overflow: .ellipsis,
                        style: TextStyles.font14Weight700
                      ),
                    ),
                    Icon(
                      _transaction.isSuccessful ? Icons.check_circle : Icons.cancel,
                      size: 16.0,
                      color: statusColor
                    )
                  ],
                ),
                Text(
                  _transaction.description,
                  overflow: .ellipsis,
                  style: TextStyles.font12Weight400.copyWith(color: Colors.grey)
                ),
                Text(
                  DateFormatter.formatDate(context, _transaction.date),
                  style: TextStyles.font12Weight400.copyWith(color: Colors.grey)
                )
              ],
            ),
          ),
          Text(
            "${_transaction.type.isCredit ? "+" : "-"}${NumberFormat.decimalPattern(context.l10n.localeName).format(_transaction.amount)} ${context.l10n.pound}",
            textDirection: .ltr,
            style: TextStyles.font16Weight700.copyWith(color: amountColor)
          )
        ],
      ),
    );
  }
}
