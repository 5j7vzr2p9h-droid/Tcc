import 'package:flutter/material.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/add_new_button.dart';
import '../../../../core/widgets/secured_info_footer.dart';
import '../../domain/entities/saved_address_entity.dart';
import '../widgets/saved_address_card.dart';

final class SavedAddressesPage extends StatelessWidget {
  const new({super.key});

  static const List<SavedAddressEntity> _addresses = <SavedAddressEntity>[
    SavedAddressEntity(
      label: "المنزل",
      address: "شارع النزهة، مدينة نصر، القاهرة",
      details: "العمارة 12، الشقة 3، الدور 2",
      phoneNumber: "0101 234 5678",
      isDefault: true
    ),
    SavedAddressEntity(
      label: "العمل",
      address: "شارع 90 الشمالي، التجمع الخامس، القاهرة",
      details: "مبنى B1، الدور الأرضي",
      phoneNumber: "0109 876 5432"
    ),
    SavedAddressEntity(
      label: "المنزل (الفرعي)",
      address: "شارع جامعة الدول العربية، المهندسين، الجيزة",
      details: "العمارة 7، الشقة 5، الدور 1",
      phoneNumber: "0111 111 1111"
    ),
    SavedAddressEntity(
      label: "بيت العائلة",
      address: "شارع فيصل، الهرم، الجيزة",
      details: "العمارة 25، الشقة 10، الدور 3",
      phoneNumber: "0122 333 4444"
    )
  ];

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(context.l10n.savedAddresses, style: TextStyles.font18Weight700),
    ),
    body: CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const .all(pageContentPadding),
          sliver: SliverList.separated(
            itemCount: _addresses.length,
            separatorBuilder: (BuildContext _, int _)
            => const SizedBox(height: defaultItemsSeparator,),
            itemBuilder: (BuildContext context, int i)
            => SavedAddressCard(
              address: _addresses[i],
              onActionSelected: (SavedAddressAction _){},
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const .only(
              left: pageContentPadding,
              right: pageContentPadding,
              bottom: pageContentPadding
            ),
            child: Column(
              spacing: defaultItemsSeparator,
              crossAxisAlignment: .stretch,
              mainAxisSize: .min,
              children: <Widget>[
                AddNewButton(
                  label: context.l10n.addNewAddress,
                  onPressed: () => Navigator.pushNamed(context, Routes.selectLocation),
                ),
                SecuredInfoFooter(message: context.l10n.addressesSecured)
              ],
            ),
          ),
        )
      ],
    )
  );
}