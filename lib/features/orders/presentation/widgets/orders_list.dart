import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../domain/entities/order_entity.dart';
import 'order_card.dart';

final class const OrdersList(
  {
    super.key,
    required final List<OrderEntity> orders,
    required final Future<void> Function() _onRefresh

  }
) extends StatelessWidget {

  @override
  RefreshIndicator build(BuildContext context)
  => RefreshIndicator(
    onRefresh: _onRefresh,
    child: ListView.separated(
      padding: const .fromLTRB(
        pageContentPadding,
        pageContentPadding,
        pageContentPadding,
        120.0
      ),
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      itemCount: orders.length,
      separatorBuilder: (BuildContext _, int _) => const SizedBox(height: defaultItemsSeparator),
      itemBuilder: (BuildContext context, int i) => OrderCard(
        order: orders[i],
        onDetailsPressed: (){},
        onActionPressed: (){},
      ),
    ),
  );
}