import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/payment_method_entity.dart';
import 'payment_methods_field.dart';

final class PaymentStep extends StatefulWidget {
  final ValueNotifier<int> _paymentMethodController;

  const new({
    super.key,
    required this._paymentMethodController
  });

  @override
  State<PaymentStep> createState() => _PaymentStepState();
}

class _PaymentStepState extends State<PaymentStep> {

  @override
  SliverToBoxAdapter build(BuildContext context)
  => SliverToBoxAdapter(
    child: Padding(
      padding: const .all(pageContentPadding),
      child: Column(
        spacing: 28.0,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 12.0,
            children: <Widget>[
              Text(context.l10n.choosePaymentMethod, style: TextStyles.font18Weight700),
              PaymentMethodsField(
                controller: widget._paymentMethodController,
                methods: <PaymentMethodEntity>[
                  PaymentMethodEntity(
                    title: context.l10n.cashOnDelivery,
                    description: context.l10n.cashOnDeliveryDescription,
                    icon: SvgPicture.asset(
                      AssetsManager.money,
                      colorFilter: .mode(
                        Theme.of(context).colorScheme.primary,
                        .srcATop
                      ),
                    )
                  ),
                  PaymentMethodEntity(
                    title: context.l10n.vodafoneCash,
                    description: context.l10n.cardPaymentDescription,
                    icon: SvgPicture.asset(
                      AssetsManager.vodafone
                    )
                  ),
                  PaymentMethodEntity(
                    title: context.l10n.instapay,
                    description: context.l10n.instapayDescription,
                    icon: SvgPicture.asset(
                      AssetsManager.instapay
                    )
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}