import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../domain/entities/coupon_entity.dart';
import 'coupon_card.dart';
import 'coupons_info_card.dart';
import 'coupons_section_header.dart';

final class const CouponsList({
  super.key,
  required final List<CouponEntity> _activeCoupons,
  required final List<CouponEntity> _expiredCoupons
}) extends StatelessWidget {

  @override
  SliverMainAxisGroup build(BuildContext context)
  => SliverMainAxisGroup(
    slivers: <Widget>[
      if(_activeCoupons.isNotEmpty) ..._buildSection(
        title: context.l10n.availableCoupons,
        coupons: _activeCoupons
      ),
      if(_expiredCoupons.isNotEmpty) ..._buildSection(
        title: context.l10n.expiredCoupons,
        coupons: _expiredCoupons,
        isExpired: true
      ),
      const SliverPadding(
        padding: .only(
          left: pageContentPadding,
          right: pageContentPadding,
          bottom: pageContentPadding
        ),
        sliver: SliverToBoxAdapter(
          child: CouponsInfoCard(),
        ),
      )
    ],
  );

  List<Widget> _buildSection({
    required String title,
    required List<CouponEntity> coupons,
    bool isExpired = false
  })
  => <Widget>[
    SliverPadding(
      padding: const .only(
        left: pageContentPadding,
        right: pageContentPadding,
        bottom: defaultItemsSeparator
      ),
      sliver: SliverToBoxAdapter(
        child: CouponsSectionHeader(
          title: title,
          count: coupons.length,
          isExpired: isExpired
        ),
      ),
    ),
    SliverPadding(
      padding: const .only(
        left: pageContentPadding,
        right: pageContentPadding,
        bottom: pageContentPadding
      ),
      sliver: SliverList.separated(
        itemCount: coupons.length,
        separatorBuilder: (BuildContext _, int _) => const SizedBox(
          height: defaultItemsSeparator,
        ),
        itemBuilder: (BuildContext context, int i)
        => CouponCard(coupon: coupons[i]),
      ),
    )
  ];
}
