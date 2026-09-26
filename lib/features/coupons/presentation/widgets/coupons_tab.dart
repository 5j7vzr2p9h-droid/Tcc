import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/enums/coupon_status.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../domain/entities/coupon_entity.dart';
import 'coupon_card.dart';
import 'coupon_code_field.dart';
import 'coupons_info_card.dart';
import 'coupons_section_header.dart';

final class CouponsTab extends StatefulWidget {
  const new({super.key});

  @override
  State<CouponsTab> createState() => _CouponsTabState();
}

final class _CouponsTabState extends State<CouponsTab> {
  final TextEditingController _codeController = TextEditingController();

  static final List<CouponEntity> _coupons = <CouponEntity>[
    CouponEntity(
      code: "SWIFT20",
      title: "خصم 20% على أول طلب",
      discount: "20%",
      minimumOrder: 50,
      expiryDate: DateTime(2025, 5, 24),
      remainingUses: 3,
      totalUses: 5,
      color: Colors.deepOrange
    ),
    CouponEntity(
      code: "NEW15",
      title: "خصم 15% على جميع الطلبات",
      discount: "15%",
      minimumOrder: 60,
      expiryDate: DateTime(2025, 6, 1),
      remainingUses: 2,
      totalUses: 3,
      color: Colors.red
    ),
    CouponEntity(
      code: "FREESHIP",
      title: "شحن مجاني على جميع الطلبات",
      minimumOrder: 40,
      expiryDate: DateTime(2025, 6, 10),
      color: Colors.deepPurple
    ),
    CouponEntity(
      code: "OLD10",
      title: "خصم 10% على الطلبات",
      discount: "10%",
      minimumOrder: 50,
      expiryDate: DateTime(2025, 4, 15),
      color: Colors.grey,
      status: .expired
    )
  ];

  static final List<CouponEntity> _availableCoupons = _coupons.where(
    (CouponEntity coupon) => coupon.status == CouponStatus.active
  ).toList();

  static final List<CouponEntity> _expiredCoupons = _coupons.where(
    (CouponEntity coupon) => coupon.status == CouponStatus.expired
  ).toList();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  CustomScrollView build(BuildContext context)
  => CustomScrollView(
    physics: const BouncingScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Padding(
          padding: const .all(pageContentPadding),
          child: CouponCodeField(
            controller: _codeController,
            onApplyPressed: (){},
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const .only(
            left: pageContentPadding,
            right: pageContentPadding,
            bottom: defaultItemsSeparator
          ),
          child: CouponsSectionHeader(
            title: context.l10n.availableCoupons,
            count: _availableCoupons.length
          ),
        ),
      ),
      SliverPadding(
        padding: const .only(
          left: pageContentPadding,
          right: pageContentPadding,
          bottom: pageContentPadding,
        ),
        sliver: SliverList.separated(
          itemCount: _availableCoupons.length,
          separatorBuilder: (BuildContext _, int _) => const SizedBox(
            height: defaultItemsSeparator,
          ),
          itemBuilder: (BuildContext context, int i)
          => CouponCard(coupon: _availableCoupons[i]),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const .symmetric(horizontal: pageContentPadding),
          child: CouponsSectionHeader(
            title: context.l10n.expiredCoupons,
            count: _expiredCoupons.length,
            isExpired: true
          ),
        ),
      ),
      SliverPadding(
        padding: const .only(
          left: pageContentPadding,
          right: pageContentPadding,
          top: defaultItemsSeparator,
          bottom: pageContentPadding
        ),
        sliver: SliverList.separated(
          itemCount: _expiredCoupons.length,
          separatorBuilder: (BuildContext _, int _) => const SizedBox(
            height: defaultItemsSeparator,
          ),
          itemBuilder: (BuildContext context, int i)
          => CouponCard(coupon: _expiredCoupons[i]),
        )
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const .only(
            left: pageContentPadding,
            right: pageContentPadding,
            bottom: pageContentPadding
          ),
          child: CouponsInfoCard(),
        ),
      )
    ],
  );
}
