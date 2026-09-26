import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/labeled_tab_bar.dart';
import '../widgets/coupons_tab.dart';
import '../widgets/offers_tab.dart';

final class CouponsAndOffersPage extends StatefulWidget {
  const new({super.key});

  @override
  State<CouponsAndOffersPage> createState() => _CouponsAndOffersPageState();
}

final class _CouponsAndOffersPageState extends State<CouponsAndOffersPage> with SingleTickerProviderStateMixin {
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
      centerTitle: true,
      toolbarHeight: 72.0,
      title: Column(
        mainAxisSize: .min,
        spacing: 4.0,
        children: <Text>[
          Text(context.l10n.couponsOffers, style: TextStyles.font18Weight700),
          Text(
            context.l10n.couponsSubtitle,
            style: TextStyles.font12Weight400.copyWith(color: Colors.grey)
          )
        ],
      ),
    ),
    body: Column(
      children: <Widget>[
        LabeledTabBar(
          tabController: _tabController,
          labels: <String>[
            context.l10n.couponsTab,
            context.l10n.offersTab
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const <Widget>[
              CouponsTab(),
              OffersTab()
            ],
          ),
        )
      ],
    ),
  );
}
