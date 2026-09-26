import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/icon_label.dart';
import '../../../delivery/presentation/widgets/delivery_bottom_bar.dart';
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

  int _currentStep = 1;
  final ValueNotifier<int> _paymentMethodController = ValueNotifier<int>(0);

  @override
  void dispose(){
    _paymentMethodController.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context) {
    final List<String> steps = <String>[
      context.l10n.cart,
      context.l10n.delivery,
      context.l10n.payment
    ];
    return Scaffold(
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
            2 => const DeliveryStep(),
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
            total: 199,
            onContinuePressed: () => setState(() => _currentStep++)
          ),
          PaymentBottomAppBar(
            () {
              switch(_paymentMethodController.value){
                case 0:
                  ////
                  break;
                case 1:
                  _showVodafoneDialog();
                  break;
                case 2:
                  _showInstaPayDialog();
                  
              }
            }
          )
        ][_currentStep -  1],
      )
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
