import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../domain/entities/order_entity.dart';
import 'order_card.dart';
import 'orders_filter_dropdown_button.dart';

final class PreviousOrdersTab extends StatefulWidget {
  const new({super.key});

  @override
  State<PreviousOrdersTab> createState() => _PreviousOrdersTabState();
}

final class _PreviousOrdersTabState extends State<PreviousOrdersTab> {
  final ValueNotifier<String> _selectedFilter = ValueNotifier<String>(OrdersFilterDropdownButton.filters.first);

  static final List<OrderEntity> _orders = <OrderEntity>[
    OrderEntity(
      number: "12410",
      address: "مدينة نصر، القاهرة",
      image: "https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg",
      date: DateTime(2024, 5, 18, 20, 15),
      total: 150.0,
      status: .completed
    ),
    OrderEntity(
      number: "12322",
      address: "المعادي، القاهرة",
      image: "https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg",
      date: DateTime(2024, 5, 16, 14, 10),
      total: 95.0,
      status: .completed
    ),
    OrderEntity(
      number: "12201",
      address: "6 أكتوبر، الجيزة",
      image: "https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg",
      date: DateTime(2024, 5, 13, 21, 30),
      total: 180.0,
      status: .completed
    ),
    OrderEntity(
      number: "12055",
      address: "شبرا، القاهرة",
      image: "https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg",
      date: DateTime(2024, 5, 10, 19, 0),
      total: 130.0,
      status: .completed
    ),
  ];

  @override
  void dispose() {
    _selectedFilter.dispose();
    super.dispose();
  }

  @override
  Column build(BuildContext context)
  => Column(
    crossAxisAlignment: .start,
    children: <Widget>[
      Padding(
        padding: const .only(
          top: pageContentPadding,
          right: pageContentPadding,
          left: pageContentPadding,
          bottom: 4.0
        ),
        child: OrdersFilterDropdownButton(
          selectedFilter: _selectedFilter,
        ),
      ),
      Expanded(
        child: ListView.separated(
          padding: const .fromLTRB(
            pageContentPadding,
            pageContentPadding,
            pageContentPadding,
            120.0
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: _orders.length,
          separatorBuilder: (BuildContext _, int _) => const SizedBox(height: defaultItemsSeparator),
          itemBuilder: (BuildContext context, int i) => OrderCard(
            order: _orders[i],
            onDetailsPressed: (){},
            onActionPressed: (){},
          ),
        ),
      )
    ],
  );
}
