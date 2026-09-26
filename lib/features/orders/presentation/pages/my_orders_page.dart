import 'package:flutter/material.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../widgets/current_orders_tab.dart';
import '../widgets/orders_tab_bar.dart';
import '../widgets/previous_orders_tab.dart';

final class MyOrdersTab extends StatefulWidget {
  const new({super.key});

  @override
  State<MyOrdersTab> createState() => _MyOrdersTabState();
}

final class _MyOrdersTabState extends State<MyOrdersTab> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 2,
    vsync: this
  );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      title: Text(context.l10n.myOrders, style: TextStyles.font18Weight700),
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
      actions: <IconButton>[
        IconButton(
          onPressed: () => Navigator.pushNamed(context, Routes.payment),
          icon: const Icon(Icons.shopping_cart_outlined)
        )
      ],
    ),
    body: Column(
      children: <Widget>[
        OrdersTabBar(tabController: _tabController),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const <Widget>[
              CurrentOrdersTab(),
              PreviousOrdersTab()
            ],
          ),
        )
      ],
    ),
  );
}
