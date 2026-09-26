import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../domain/entities/offer_entity.dart';
import 'offer_card.dart';

final class OffersTab extends StatelessWidget {
  const new({super.key});

  static final List<OfferEntity> _offers = <OfferEntity>[
    OfferEntity(
      title: "خصم 20% على وجبات البرجر",
      description: "استمتع بخصم 20% على جميع وجبات البرجر عند الطلب من التطبيق.",
      image: "https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg",
      validUntil: DateTime(2025, 6, 30)
    ),
    OfferEntity(
      title: "بيتزا وسط + مشروب مجاني",
      description: "اطلب أي بيتزا وسط واحصل على مشروب غازي مجاناً.",
      image: "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_1280.jpg",
      validUntil: DateTime(2025, 7, 15)
    ),
    OfferEntity(
      title: "توصيل مجاني لأول 3 طلبات",
      description: "احصل على توصيل مجاني لأول ثلاث طلبات لك خلال هذا الشهر.",
      image: "https://cdn.pixabay.com/photo/2022/08/31/10/17/burger-7422970_1280.jpg",
      validUntil: DateTime(2025, 8, 1)
    )
  ];

  @override
  ListView build(BuildContext context)
  => ListView.separated(
    padding: const .all(pageContentPadding),
    physics: const BouncingScrollPhysics(),
    itemCount: _offers.length,
    separatorBuilder: (BuildContext context, int _) => const SizedBox(height: defaultItemsSeparator),
    itemBuilder: (BuildContext context, int i) => OfferCard(
      offer: _offers[i],
      onOrderPressed: (){},
    ),
  );
}
