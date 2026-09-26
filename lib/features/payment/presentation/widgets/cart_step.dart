import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../cart/presentation/widgets/cart_item_card.dart';

final class CartStep extends StatelessWidget {
  const new({super.key});

  @override
  SliverMainAxisGroup build(BuildContext context)
  => SliverMainAxisGroup(
    slivers: <Widget>[
      SliverPadding(
        padding: const .all(pageContentPadding),
        sliver: SliverList.separated(
          itemCount: 3,
          separatorBuilder: (BuildContext _, int _) => const SizedBox(height: defaultItemsSeparator),
          itemBuilder: (BuildContext context, int i) => CartItemCard(
            item: CartItemEntity(
              image: "https://cdn.pixabay.com/photo/2022/08/31/10/17/burger-7422970_1280.jpg",
              name: "كلاسيك برجر",
              description: "قطعة لحم بقري، جبنة شيدر، طماطم، خس، صوص خاص",
              price: 120.0,
            ),
          ),
        ),
      ),
      // SliverPadding(
      //   padding: const .only(
      //     left: pageContentPadding,
      //     right: pageContentPadding,
      //     bottom: pageContentPadding
      //   ),
      //   sliver: SliverToBoxAdapter(
      //     child: Column(
      //       spacing: 16.0,
      //       children: <Widget>[
      //         OrderSummaryField(
      //           itemsTotal: 1,
      //           deliveryFee: 15.0,
      //         ),
      //         ElevatedButton(
      //           onPressed: _onEndButtonPressed,
      //           child: Text(context.l10n.resumePayment)
      //         )
      //       ],
      //     ),
      //   ),
      // )
    ],
  );
}