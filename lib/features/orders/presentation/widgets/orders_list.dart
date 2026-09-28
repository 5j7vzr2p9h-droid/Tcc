import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../domain/entities/order_entity.dart';
import 'order_card.dart';

final class const OrdersList(final List<OrderEntity> orders, {super.key}) extends StatelessWidget {

  @override
  ListView build(BuildContext context)
  => ListView.separated(
    padding: const .fromLTRB(
      pageContentPadding,
      pageContentPadding,
      pageContentPadding,
      120.0
    ),
    physics: const BouncingScrollPhysics(),
    itemCount: orders.length,
    separatorBuilder: (BuildContext _, int _) => const SizedBox(height: defaultItemsSeparator),
    itemBuilder: (BuildContext context, int i) => OrderCard(
      order: orders[i],
      onDetailsPressed: (){},
      onActionPressed: (){},
    ),
  );
}