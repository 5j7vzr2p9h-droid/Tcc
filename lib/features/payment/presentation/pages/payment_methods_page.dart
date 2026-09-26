import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/add_new_button.dart';
import '../../../../core/widgets/secured_info_footer.dart';
import '../../domain/entities/saved_payment_method_entity.dart';
import '../widgets/saved_payment_method_card.dart';

final class PaymentMethodsPage extends StatelessWidget {
  const new({super.key});

  @override
  Scaffold build(BuildContext context) {
    final List<SavedPaymentMethodEntity> methods = <SavedPaymentMethodEntity>[
      const SavedPaymentMethodEntity(
        title: "Mastercard",
        cardLastDigits: "4567",
        icon: Icon(Icons.place),
        isDefault: true
      ),
      SavedPaymentMethodEntity(
        title: "Visa",
        cardLastDigits: "8901",
        icon: SvgPicture.asset(AssetsManager.visa)
      ),
      const SavedPaymentMethodEntity(
        title: "مدى",
        cardLastDigits: "1122",
        icon: Icon(Icons.place)
      ),
      SavedPaymentMethodEntity(
        title: context.l10n.cashOnDelivery,
        icon: SvgPicture.asset(
          AssetsManager.money,
          colorFilter: .mode(
            Theme.of(context).colorScheme.primary,
            .srcATop
          ),
        )
      )
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0.0,
        title: Text(context.l10n.paymentMethods, style: TextStyles.font18Weight700),
      ),
      body: ListView(
        padding: const .all(pageContentPadding),
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Text(
            context.l10n.savedPaymentMethods,
            style: TextStyles.font18Weight700
          ),
          const SizedBox(height: defaultItemsSeparator),
          Column(
            spacing: defaultItemsSeparator,
            children: <SavedPaymentMethodCard>[
              for(final SavedPaymentMethodEntity method in methods)
                SavedPaymentMethodCard(
                  method: method,
                  onTap: (){},
                )
            ],
          ),
          const SizedBox(height: 24.0),
          AddNewButton(
            label: context.l10n.addNewPaymentMethod,
            onPressed: (){},
          ),
          const SizedBox(height: 24.0),
          SecuredInfoFooter(message: context.l10n.paymentMethodsSecured)
        ],
      ),
    );
  }
}
