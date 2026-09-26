import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/widgets/order_summary_field.dart';

class CartBottomAppBar extends StatelessWidget {
  final VoidCallback _onNexPressed;

  const new(this._onNexPressed, {super.key});

  @override
  Column build(BuildContext context)
  => Column(
    mainAxisSize: .min,
    spacing: 16.0,
    children: <Widget>[
      const OrderSummaryField(
        itemsTotal: 1,
        deliveryFee: 15.0,
      ),
      ElevatedButton(
        onPressed: _onNexPressed,
        child: Text(context.l10n.resumePayment)
      )
    ],
  );
}