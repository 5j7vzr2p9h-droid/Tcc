import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/enums/delivery_method.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/icon_label.dart';
import '../../../cart/presentation/viewmodel/cart_cubit.dart';
import '../../../delivery/presentation/widgets/delivery_bottom_bar.dart';
import '../../domain/entities/checkout_entity.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../viewmodels/checkout_viewmodel/checkout_cubit.dart';
import '../viewmodels/checkout_viewmodel/checkout_state.dart';
import '../viewmodels/payment_methods_viewmodel/payment_methods_cubit.dart';
import '../viewmodels/payment_methods_viewmodel/payment_methods_state.dart';
import '../widgets/cart_bottom_app_bar.dart';
import '../widgets/cart_step.dart';
import '../widgets/checkout_stepper.dart';
import '../widgets/delivery_step.dart';
import '../widgets/payment_bottom_app_bar.dart';
import '../widgets/payment_step.dart';

final class PaymentPage extends StatefulWidget {
  const new({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  static const String _vfCash = "01200000000";

  /// Backend code of the InstaPay payment method.
  static const String _instaPayCode = "Instapay";

  int _currentStep = 1;
  final ValueNotifier<PaymentMethodEntity?> _paymentMethodController = ValueNotifier<PaymentMethodEntity?>(null);
  final ValueNotifier<DeliveryMethod> _deliveryMethodController = ValueNotifier<DeliveryMethod>(.delivery);

  @override
  void dispose(){
    _paymentMethodController.dispose();
    _deliveryMethodController.dispose();
    super.dispose();
  }

  void _checkout()
  => context.read<CheckoutCubit>().checkout(
    CheckoutEntity(
      deliveryMethod: _deliveryMethodController.value,
      paymentMethodId: _paymentMethodController.value!.id,
      items: context.read<CartCubit>().state.items
    )
  );

  /// Methods that require a proof of payment ask for it before the order is sent.
  void _onConfirmOrderPressed(){
    final PaymentMethodEntity? method = _paymentMethodController.value;
    if(method == null) return;

    if(!method.requiresProof) _checkout();
    else if(method.code == _instaPayCode) _showInstaPayDialog();
    else _showVodafoneDialog();
  }

  /// Selects the first method once they're loaded, unless the user already picked one.
  void _onPaymentMethodsStateChanged(BuildContext context, PaymentMethodsState state){
    if(state case PaymentMethodsGetSuccessState(:final List<PaymentMethodEntity> methods) when methods.isNotEmpty)
      _paymentMethodController.value ??= methods.first;
  }

  void _onCheckoutStateChanged(BuildContext context, CheckoutState state){
    switch(state){
      case CheckoutSuccessState():
        context.read<CartCubit>().clearCart();
        SnackBarMessage.showSuccessMessage(context, context.l10n.orderPlacedMessage);
        Navigator.pop(context);
      case CheckoutFailureState(:final Failure failure):
        SnackBarMessage.showErrorMessage(context, failure.mapFailureToMessage(context));
      case CheckoutIdleState() || CheckoutLoadingState():
        break;
    }
  }

  @override
  MultiBlocListener build(BuildContext context) {
    final List<String> steps = <String>[
      context.l10n.cart,
      context.l10n.delivery,
      context.l10n.payment
    ];
    return MultiBlocListener(
      listeners: <BlocListener>[
        BlocListener<CheckoutCubit, CheckoutState>(
          listener: _onCheckoutStateChanged
        ),
        BlocListener<PaymentMethodsCubit, PaymentMethodsState>(
          listener: _onPaymentMethodsStateChanged
        )
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(steps[_currentStep - 1]), centerTitle: true),
        body: CustomScrollView(
          slivers: <Widget>[
            CheckoutStepper(
              steps: steps,
              currentStep: _currentStep,
              onClickedOnDone: (int clickedStep) => setState(() => _currentStep = clickedStep),
            ),
            switch(_currentStep){
              1 => const CartStep(),
              2 => DeliveryStep(
                methodController: _deliveryMethodController
              ),
              _ => PaymentStep(
                paymentMethodController: _paymentMethodController
              )
            }
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: const .all(.circular(24.0)),
            border: .all(color: Theme.of(context).colorScheme.outline, width: 2.0),
            color: Theme.of(context).scaffoldBackgroundColor
          ),
          padding: const .all(pageContentPadding),
          child: [
            CartBottomAppBar(
              () => setState(() => _currentStep++)
            ),
            DeliveryBottomAppBar(
              total: context.select<CartCubit, double>((CartCubit cubit) => cubit.state.subtotal) + deliveryFee,
              onContinuePressed: () => setState(() => _currentStep++)
            ),
            PaymentBottomAppBar(
              _onConfirmOrderPressed,
              isLoading: context.select<CheckoutCubit, bool>(
                (CheckoutCubit cubit) => cubit.state is CheckoutLoadingState
              )
            )
          ][_currentStep -  1],
        )
      ),
    );
  }
  
  void _showInstaPayDialog()
  => showDialog(
    context: context,
    builder: (BuildContext context) {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      return AlertDialog(
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: .min,
            spacing: 8.0,
            children: <Widget>[
              TextFormField(
                autovalidateMode: .onUserInteraction,
                validator: Validators.getInstaPayUsernameValidator(context),
                style: TextStyles.font12Weight700,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  hintText: context.l10n.enterInstaPayUsername,
                  border: const OutlineInputBorder(
                    borderRadius: .all(.circular(12.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: .all(.circular(16.0)),
                    borderSide: .none
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  if(formKey.currentState!.validate()){
                    Navigator.pop(context);
                    _checkout();
                  }
                },
                child: Text(context.l10n.confirmPayment)
              )
            ],
          ),
        )
      );
    }
  );

  void _showVodafoneDialog()
  => showDialog(
    context: context,
    builder: (BuildContext context) {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      return AlertDialog(
        content: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: 8.0,
            children: <Widget>[
              IconLabel(
                icon: Icons.info_outline,
                label: context.l10n.sendMoneyToNumber,
                color: Theme.of(context).colorScheme.primary,
              ),
              TextField(
                readOnly: true,
                textAlign: .center,
                decoration: InputDecoration(
                  filled: true,
                  hintText: _vfCash,
                  fillColor: Colors.grey.shade300,
                  prefixIcon: IconButton(
                    onPressed: () => Clipboard.setData(const ClipboardData(text: _vfCash)),
                    icon: const Icon(Icons.copy)
                  )
                ),
              ),
              TextFormField(
                autovalidateMode: .onUserInteraction,
                validator: Validators.getPhoneNumberValidator(context),
                style: TextStyles.font12Weight700,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  hintText: context.l10n.enterWalletNumber,
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  if(formKey.currentState!.validate()){
                    Navigator.pop(context);
                    _checkout();
                  }
                },
                child: Text(context.l10n.confirmPayment)
              )
            ],
          ),
        )
      );
    }
  );
}
