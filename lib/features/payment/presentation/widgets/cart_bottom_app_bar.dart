import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/widgets/order_summary_field.dart';
import '../../../cart/presentation/viewmodel/cart_cubit.dart';
import '../../../cart/presentation/viewmodel/cart_state.dart';

class CartBottomAppBar extends StatelessWidget {
  final VoidCallback _onNexPressed;

  const new(this._onNexPressed, {super.key});

  @override
  BlocBuilder<CartCubit, CartState> build(BuildContext context)
  => BlocBuilder<CartCubit, CartState>(
    builder: (BuildContext context, CartState state)
    => Column(
      mainAxisSize: .min,
      spacing: 16.0,
      children: <Widget>[
        OrderSummaryField(
          itemsTotal: state.subtotal,
          deliveryFee: deliveryFee,
        ),
        ElevatedButton(
          onPressed: state.isEmpty ? null : _onNexPressed,
          child: Text(context.l10n.resumePayment)
        )
      ],
    ),
  );
}
