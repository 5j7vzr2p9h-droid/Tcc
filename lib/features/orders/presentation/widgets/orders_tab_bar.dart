import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class OrdersTabBar extends StatelessWidget{
  final TabController _tabController;

  const new({
    super.key,
    required this._tabController
  });

  @override
  TabBar build(BuildContext context)
  => TabBar(
    controller: _tabController,
    labelStyle: TextStyles.font16Weight700,
    labelColor: Theme.of(context).colorScheme.onSurface,
    unselectedLabelColor: Colors.grey,
    indicatorColor: Theme.of(context).colorScheme.error,
    indicatorSize: .tab,
    padding: const .symmetric(horizontal: pageContentPadding),
    indicatorWeight: 3.0,
    dividerColor: Colors.transparent,
    tabs: <Tab>[
      Tab(text: context.l10n.currentOrders),
      Tab(text: context.l10n.previousOrders)
    ],
  );
}
