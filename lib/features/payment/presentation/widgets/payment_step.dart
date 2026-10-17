import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/enums/payment_method.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/icon_label.dart';
import '../../../wallet/presentation/viewmodels/balance_viewmodel/balance_cubit.dart';
import '../../../wallet/presentation/viewmodels/balance_viewmodel/balance_state.dart';
import 'insta_pay_dialog.dart';
import 'payment_method_tile.dart';
import 'vodafone_cash_dialog.dart';

final class const PaymentStep({
  super.key,
  required final ValueNotifier<PaymentMethod> _paymentMethodController
}) extends StatelessWidget {

  /// Tops up with the same method the button was pressed under.
  void _showTopUpDialog(BuildContext context, PaymentMethod method){
    // TODO: Send the top-up request before refreshing the balance once the backend endpoint is available.
    final VoidCallback onConfirm = context.read<BalanceCubit>().init;

    showDialog(
      context: context,
      builder: (BuildContext context) => method == .instaPay
        ? InstaPayDialog(onConfirm: onConfirm)
        : VodafoneCashDialog(onConfirm: onConfirm)
    );
  }

  Widget _buildBalance(BuildContext context)
  => BlocBuilder<BalanceCubit, BalanceState>(
    builder: (BuildContext context, BalanceState state)
    => switch(state){
      BalanceInitialState() || BalanceLoadingState() => const Padding(
        padding: .symmetric(vertical: 4.0),
        child: SizedBox.square(
          dimension: 14.0,
          child: CircularProgressIndicator(strokeWidth: 2.0),
        ),
      ),
      BalanceGetFailureState() => InkWell(
        onTap: context.read<BalanceCubit>().init,
        child: IconLabel(
          icon: Icons.refresh,
          color: Theme.of(context).colorScheme.error,
          label: context.l10n.retry
        ),
      ),
      BalanceGetSuccessState(:final double balance) => IconLabel(
        icon: Icons.wallet,
        color: Theme.of(context).colorScheme.primary,
        label: "${context.l10n.yourCurrentBalance}: ${balance.toStringAsFixed(2)} ${context.l10n.pound}"
      )
    }
  );

  /// The same wallet balance from the server, shown under every method that isn't cash.
  Column _buildBalanceWithTopUp(BuildContext context, PaymentMethod method)
  => Column(
    crossAxisAlignment: .start,
    children: <Widget>[
      _buildBalance(context),
      TextButton.icon(
        onPressed: () => _showTopUpDialog(context, method),
        style: TextButton.styleFrom(
          padding: .zero,
          visualDensity: .compact,
          tapTargetSize: .shrinkWrap
        ),
        icon: const Icon(Icons.add_circle_outline, size: 18.0),
        label: Text(context.l10n.topUpBalance)
      )
    ],
  );

  static String _methodTitle(BuildContext context, PaymentMethod method)
  => switch(method){
    .cash => context.l10n.cashOnDelivery,
    .instaPay => context.l10n.instapay,
    .vodafoneCash => context.l10n.vodafoneCash
  };

  @override
  SliverToBoxAdapter build(BuildContext context)
  => SliverToBoxAdapter(
    child: Padding(
      padding: const .all(pageContentPadding),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12.0,
        children: <Widget>[
          Text(context.l10n.choosePaymentMethod, style: TextStyles.font18Weight700),
          ValueListenableBuilder<PaymentMethod>(
            valueListenable: _paymentMethodController,
            builder: (BuildContext context, PaymentMethod value, Widget? child)
            => Column(
              spacing: 12.0,
              children: <Widget>[
                for (final PaymentMethod method in PaymentMethod.values)
                  PaymentMethodTile(
                    title: _methodTitle(context, method),
                    selected: value == method,
                    onTap: () => _paymentMethodController.value = method,
                    child: method == .cash? null: _buildBalanceWithTopUp(context, method)
                  )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
