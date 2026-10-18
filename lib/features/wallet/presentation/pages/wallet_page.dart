import 'package:flutter/material.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../domain/entities/wallet_transaction_entity.dart';
import '../widgets/recent_transactions_header.dart';
import '../widgets/top_up_balance_button.dart';
import '../widgets/wallet_balance_card.dart';
import '../widgets/wallet_transaction_card.dart';

final class const WalletPage({super.key}) extends StatelessWidget {

  @override
  Scaffold build(BuildContext context) {

    final List<WalletTransactionEntity> transactions = <WalletTransactionEntity>[
      WalletTransactionEntity(
        type: .payment,
        amount: 850.0,
        description: "#10482",
        date: DateTime.now().subtract(const Duration(hours: 2)),
        isSuccessful: true
      ),
      WalletTransactionEntity(
        type: .topUp,
        amount: 2000.0,
        description: "InstaPay",
        date: DateTime.now().subtract(const Duration(hours: 3)),
        isSuccessful: true
      ),
      WalletTransactionEntity(
        type: .refund,
        amount: 350.0,
        description: "#10475",
        date: DateTime.now().subtract(const Duration(days: 1)),
        isSuccessful: true
      ),
      WalletTransactionEntity(
        type: .payment,
        amount: 850.0,
        description: "#10471",
        date: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
        isSuccessful: false
      )
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.l10n.wallet),
      ),
      body: ListView(
        padding: const .all(pageContentPadding),
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          WalletBalanceCard(balance: 120),
          const SizedBox(height: 16.0),
          TopUpBalanceButton(
            onTap: () => Navigator.pushNamed(
              context,
              Routes.topup
            ),
          ),
          const SizedBox(height: 24.0),
          RecentTransactionsHeader(
            onViewAll: () => Navigator.pushNamed(
              context,
              Routes.walletTransactions,
              arguments: transactions
            ),
          ),
          const SizedBox(height: defaultItemsSeparator),
          Column(
            spacing: defaultItemsSeparator,
            children: <WalletTransactionCard>[
              for(final WalletTransactionEntity transaction in transactions)
                WalletTransactionCard(transaction: transaction)
            ],
          )
        ],
      ),
    );
  }
}
