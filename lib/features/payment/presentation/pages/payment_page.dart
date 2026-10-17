import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/enums/delivery_method.dart';
import '../../../../core/enums/payment_method.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../cart/presentation/viewmodel/cart_cubit.dart';
import '../../../delivery/domain/entities/address_entity.dart';
import '../../../delivery/presentation/viewmodels/saved_address_model/saved_addresses_cubit.dart';
import '../../../delivery/presentation/viewmodels/saved_address_model/saved_addresses_state.dart';
import '../../../delivery/presentation/widgets/delivery_bottom_bar.dart';
import '../../domain/entities/checkout_entity.dart';
import '../viewmodels/checkout_viewmodel/checkout_cubit.dart';
import '../viewmodels/checkout_viewmodel/checkout_state.dart';
import '../widgets/cart_bottom_app_bar.dart';
import '../widgets/cart_step.dart';
import '../widgets/checkout_stepper.dart';
import '../widgets/delivery_step.dart';
import '../widgets/insta_pay_dialog.dart';
import '../widgets/payment_bottom_app_bar.dart';
import '../widgets/payment_step.dart';
import '../widgets/vodafone_cash_dialog.dart';

final class PaymentPage extends StatefulWidget {
  const new({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _currentStep = 1;
  final ValueNotifier<PaymentMethod> _paymentMethodController = ValueNotifier<PaymentMethod>(.cash);
  final ValueNotifier<DeliveryMethod> _deliveryMethodController = ValueNotifier<DeliveryMethod>(.delivery);
  final ValueNotifier<AddressEntity?> _addressController = ValueNotifier<AddressEntity?>(null);
  late final Listenable _deliveryListenable = Listenable.merge(<Listenable>[_deliveryMethodController, _addressController]);

  @override
  void dispose(){
    _paymentMethodController.dispose();
    _deliveryMethodController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  bool get _isDelivery => _deliveryMethodController.value == .delivery;

  /// Null when picking up from the branch or while no address is chosen yet.
  double? get _deliveryFee => _isDelivery ? _addressController.value?.deliveryFee : null;

  /// Keeps the chosen address after reloading, otherwise falls back to the default one.
  void _onAddressesStateChanged(BuildContext context, SavedAddressesState state){
    if(state is! SavedAddressesGetSuccessState)
      return;

    final int? selectedId = _addressController.value?.id;
    _addressController.value =
      state.addresses.where((AddressEntity address) => address.id == selectedId).firstOrNull ??
      state.addresses.where((AddressEntity address) => address.isDefault).firstOrNull ??
      state.addresses.firstOrNull;
  }

  void _checkout()
  => context.read<CheckoutCubit>().checkout(
    CheckoutEntity(
      deliveryMethod: _deliveryMethodController.value,
      paymentMethodId: _paymentMethodController.value.id,
      addressId: _isDelivery ? _addressController.value?.id : null,
      items: context.read<CartCubit>().state.items
    )
  );

  /// Methods that require a proof of payment ask for it before the order is sent.
  void _onConfirmOrderPressed()
  => switch(_paymentMethodController.value){
    .cash => _checkout(),
    .instaPay => _showInstaPayDialog(),
    .vodafoneCash => _showVodafoneDialog()
  };

  void _onCheckoutStateChanged(BuildContext context, CheckoutState state){
    switch(state){
      case CheckoutSuccessState():
        context.read<CartCubit>().clearCart();
        SnackBarMessage.showSuccessMessage(context, context.l10n.orderPlacedMessage);
        Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
      case CheckoutFailureState(:final Failure failure):
        SnackBarMessage.showErrorMessage(context, failure.mapFailureToMessage(context));
      case CheckoutIdleState() || CheckoutLoadingState():
        break;
    }
  }

  @override
  BlocListener<CheckoutCubit, CheckoutState> build(BuildContext context) {
    final List<String> steps = <String>[
      context.l10n.cart,
      context.l10n.delivery,
      context.l10n.payment
    ];
    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: _onCheckoutStateChanged,
      child: BlocListener<SavedAddressesCubit, SavedAddressesState>(
        listener: _onAddressesStateChanged,
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
                  methodController: _deliveryMethodController,
                  addressController: _addressController
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
            child: ListenableBuilder(
              listenable: _deliveryListenable,
              builder: (BuildContext context, Widget? child)
              => [
                CartBottomAppBar(
                  () => setState(() => _currentStep++)
                ),
                DeliveryBottomAppBar(
                  total: context.select<CartCubit, double>((CartCubit cubit) => cubit.state.subtotal),
                  deliveryFee: _deliveryFee,
                  // Delivery can't go on before an address is chosen.
                  onContinuePressed: _isDelivery && _addressController.value == null
                    ? null
                    : () => setState(() => _currentStep++),
                ),
                PaymentBottomAppBar(
                  _onConfirmOrderPressed,
                  deliveryFee: _deliveryFee ?? 0.0,
                  isLoading: context.select<CheckoutCubit, bool>(
                    (CheckoutCubit cubit) => cubit.state is CheckoutLoadingState
                  )
                )
              ][_currentStep -  1],
            ),
          )
        ),
      ),
    );
  }

  void _showInstaPayDialog()
  => showDialog(
    context: context,
    builder: (BuildContext context) => InstaPayDialog(onConfirm: _checkout)
  );

  void _showVodafoneDialog()
  => showDialog(
    context: context,
    builder: (BuildContext context) => VodafoneCashDialog(onConfirm: _checkout)
  );
}
