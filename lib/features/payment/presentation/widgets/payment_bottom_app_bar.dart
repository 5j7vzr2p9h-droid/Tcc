import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/order_summary_field.dart';

class PaymentBottomAppBar extends StatelessWidget {
  final VoidCallback _onNexPressed;

  const new(this._onNexPressed, {super.key});

  @override
  Column build(BuildContext context)
  => Column(
    mainAxisSize: .min,
    spacing: 12.0,
    children: [
      const OrderSummaryField(
        itemsTotal: 120.0,
        deliveryFee: 15.0,
      ),
      Column(
        spacing: 12.0,
        children: <Widget>[
          ElevatedButton(
          onPressed: _onNexPressed,
            child: Text(context.l10n.confirmOrder)
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