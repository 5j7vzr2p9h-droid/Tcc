import 'package:flutter/material.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/enums/delivery_method.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../delivery/domain/entities/address_entity.dart';
import '../../../delivery/presentation/widgets/address_card.dart';
import '../../../delivery/presentation/widgets/delivery_method_selector.dart';

final class DeliveryStep extends StatefulWidget {
  final ValueNotifier<DeliveryMethod> _methodController;

  const new({
    super.key,
    required this._methodController
  });

  @override
  State<DeliveryStep> createState() => _DeliveryStepState();
}

class _DeliveryStepState extends State<DeliveryStep> {

  final ValueNotifier<int> _pickupPlaceController = ValueNotifier<int>(0);
  final ValueNotifier<AddressEntity?> _addressController = ValueNotifier<AddressEntity?>(_addresses.first);

  static const List<AddressEntity> _addresses = <AddressEntity>[
    AddressEntity(
      area: "قسم اول",
      street: "شارع البحر بجوار بنك القاهرة",
      details: "عمارة صيدلية شاهين",
      apartment: "1",
      floor: "12"
    )
  ];

  @override
  void dispose() {
    _pickupPlaceController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  SliverToBoxAdapter build(BuildContext context)
  => SliverToBoxAdapter(
    child: Padding(
      padding: const .all(pageContentPadding),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 16.0,
        children: <Widget>[
          Text("${context.l10n.chooseMethod}:", style: TextStyles.font16Weight700),
          DeliveryMethodSelector(controller: widget._methodController),
          Divider(
            height: 0.0,
            color: Theme.of(context).colorScheme.outline
          ),
          ValueListenableBuilder<DeliveryMethod>(
            valueListenable: widget._methodController,
            builder: (BuildContext context, DeliveryMethod method, Widget? child)
            => switch(method){
              .delivery => Column(
                crossAxisAlignment: .start,
                spacing: defaultItemsSeparator,
                children: <Widget>[
                  Text(
                    context.l10n.chooseAddress,
                    style: TextStyles.font16Weight700
                  ),
                  ValueListenableBuilder<AddressEntity?>(
                    valueListenable: _addressController,
                    builder: (BuildContext context, AddressEntity? selected, Widget? child)
                    => RadioGroup<AddressEntity>(
                      groupValue: selected,
                      onChanged: (AddressEntity? address) => _addressController.value = address,
                      child: Column(
                        spacing: defaultItemsSeparator,
                        children: <Widget>[
                          for(final AddressEntity address in _addresses) AddressCard(address: address)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 48.0,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, Routes.selectLocation, arguments: false),
                      icon: const Icon(Icons.add_circle_outline),
                      label: Text(context.l10n.changeAddress)
                    ),
                  ),
                ],
              ),
              .pickup => const SizedBox.shrink(),
            }
          ),
        ]
      ),
    ),
  );
}