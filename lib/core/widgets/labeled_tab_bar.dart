import 'package:flutter/material.dart';

import '../constants/numerical_values.dart';
import '../utils/text_styles.dart';

final class LabeledTabBar extends StatelessWidget {
  final TabController _tabController;
  final List<String> _labels;

  const new({
    super.key,
    required this._tabController,
    required this._labels
  });

  @override
  TabBar build(BuildContext context)
  => TabBar(
    controller: _tabController,
    labelStyle: TextStyles.font16Weight700,
    labelColor: Theme.of(context).colorScheme.primary,
    unselectedLabelColor: Colors.grey,
    indicatorColor: Theme.of(context).colorScheme.primary,
    indicatorSize: .tab,
    indicatorWeight: 3.0,
    padding: const .symmetric(horizontal: pageContentPadding),
    dividerColor: Theme.of(context).colorScheme.outline,
    tabs: <Tab>[
      for(final String label in _labels) Tab(text: label)
    ],
  );
}
