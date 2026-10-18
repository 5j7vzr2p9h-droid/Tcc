import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/order_summary_field.dart';
import '../../../cart/presentation/viewmodel/cart_cubit.dart';

final class const PaymentBottomAppBar(
  final VoidCallback _onNextPressed,
  {
    super.key,
    required final double _deliveryFee,
    final bool _isLoading = false
  }
) extends StatelessWidget {

  @override
  Column build(BuildContext context)
  => Column(
    mainAxisSize: .min,
    spacing: 12.0,
    children: <Widget>[
      OrderSummaryField(
        itemsTotal: context.select<CartCubit, double>((CartCubit cubit) => cubit.state.subtotal),
        deliveryFee: _deliveryFee,
      ),
      Column(
        spacing: 12.0,
        children: <Widget>[
          ElevatedButton(
            onPressed: _isLoading? null: _onNextPressed,
            child: _isLoading
              ? const SizedBox.square(
                dimension: 18.0,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              )
              : Text(context.l10n.confirmOrder)
          ),
          Row(
            mainAxisAlignment: .center,
            spacing: 4.0,
            children: <Widget>[
              const Icon(Icons.lock_outline, size: 14.0, color: Colors.grey),
              Text(
                context.l10n.securePaymentInfo,
                style: TextStyles.font12Weight400.copyWith(color: Colors.grey)
              )
            ],
          )
        ],
      ),
    ],
  );
}