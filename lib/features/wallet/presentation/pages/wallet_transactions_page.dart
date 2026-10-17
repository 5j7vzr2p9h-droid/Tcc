import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/wallet_transaction_entity.dart';
import '../widgets/wallet_transaction_card.dart';

final class const WalletTransactionsPage(final List<WalletTransactionEntity> _transactions, {super.key}) extends StatelessWidget {

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(context.l10n.walletTransactions, style: TextStyles.font18Weight700),
    ),
    body: ListView.separated(
      padding: const .all(pageContentPadding),
      physics: const BouncingScrollPhysics(),
      itemCount: _transactions.length,
      separatorBuilder: (BuildContext context, int _) => const SizedBox(height: defaultItemsSeparator),
      itemBuilder: (BuildContext context, int i) => WalletTransactionCard(transaction: _transactions[i]),
    ),
  );
}