import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../payment/domain/entities/payment_method_entity.dart';
import '../../../payment/presentation/viewmodels/payment_methods_viewmodel/payment_methods_cubit.dart';
import '../../../payment/presentation/viewmodels/payment_methods_viewmodel/payment_methods_state.dart';
import '../../../payment/presentation/widgets/insta_pay_dialog.dart';
import '../../../payment/presentation/widgets/vodafone_cash_dialog.dart';
import '../widgets/top_up_methods_step.dart';

final class TopupPage extends StatefulWidget {
  const new({super.key});

  @override
  State<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  final ValueNotifier<PaymentMethodEntity?> _paymentMethodController = ValueNotifier<PaymentMethodEntity?>(null);

  @override
  void dispose(){
    _paymentMethodController.dispose();
    super.dispose();
  }

  // TODO: Send the top-up request once the backend endpoint is available.
  void _topUp(){}

  void _onTopUpPressed(){
    final PaymentMethodEntity? method = _paymentMethodController.value;
    if(method == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) => method.isInstaPay
        ? InstaPayDialog(onConfirm: _topUp)
        : VodafoneCashDialog(onConfirm: _topUp)
    );
  }

  /// Selects the first top-up method once they're loaded, unless the user already picked one.
  void _onPaymentMethodsStateChanged(BuildContext context, PaymentMethodsState state){
    if(state case PaymentMethodsGetSuccessState(:final List<PaymentMethodEntity> methods))
      _paymentMethodController.value ??= methods.where(TopUpMethodsStep.isTopUpMethod).firstOrNull;
  }

  @override
  BlocListener<PaymentMethodsCubit, PaymentMethodsState> build(BuildContext context)
  => BlocListener<PaymentMethodsCubit, PaymentMethodsState>(
    listener: _onPaymentMethodsStateChanged,
    child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0.0,
        title: Text(context.l10n.topUpBalance, style: TextStyles.font18Weight700),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: TopUpMethodsStep(
              paymentMethodController: _paymentMethodController
            ),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const .all(pageContentPadding),
          child: ValueListenableBuilder<PaymentMethodEntity?>(
            valueListenable: _paymentMethodController,
            builder: (BuildContext context, PaymentMethodEntity? method, Widget? child)
            => ElevatedButton(
              onPressed: method == null? null: _onTopUpPressed,
              child: Text(context.l10n.topUpBalance)
            ),
          ),
        ),
      ),
    ),
  );
}
