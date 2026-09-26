import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../domain/entities/order_entity.dart';
import 'order_card.dart';

final class CurrentOrdersTab extends StatelessWidget {
  const new({super.key});

  static final List<OrderEntity> _orders = <OrderEntity>[
    OrderEntity(
      number: "12548",
      address: "شارع النزهة، القاهرة",
      image: "https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg",
      date: DateTime(2024, 5, 22, 18, 35),
      total: 135.0,
      status: .preparing
    ),
    OrderEntity(
      number: "12512",
      address: "شارع النزهة، القاهرة",
      image: "https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg",
      date: DateTime(2024, 5, 21, 13, 20),
      total: 120.0,
      status: .delivered
    ),
    OrderEntity(
      number: "12475",
      address: "شارع النزهة، القاهرة",
      image: "https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg",
      date: DateTime(2024, 5, 20, 19, 45),
      total: 110.0,
      status: .received
    ),
  ];

  @override
  ListView build(BuildContext context)
  => ListView.separated(
    padding: const .all(pageContentPadding),
    physics: const BouncingScrollPhysics(),
    itemCount: _orders.length,
    separatorBuilder: (BuildContext _, int _) => const SizedBox(height: defaultItemsSeparator),
    itemBuilder: (BuildContext context, int i) => OrderCard(
      order: _orders[i],
      onDetailsPressed: (){},
      onActionPressed: (){},
    ),
  );
}
