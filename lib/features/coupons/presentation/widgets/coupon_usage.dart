import 'package:flutter/material.dart';

import '../../../../core/enums/coupon_status.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/coupon_entity.dart';
import 'coupon_status_chip.dart';

final class CouponUsage extends StatelessWidget {
  final CouponEntity _coupon;

  const new({
    super.key,
    required this._coupon
  });

  @override
  SizedBox build(BuildContext context)
  => SizedBox(
    width: 104.0,
    child: Column(
      mainAxisAlignment: .center,
      spacing: 8.0,
      children: <Widget>[
        CouponStatusChip(status: _coupon.status),
        if(_coupon.status == CouponStatus.active) ...<Widget>[
          Text(
            context.l10n.remainingUses,
            textAlign: .center,
            style: TextStyles.font12Weight400.copyWith(color: Colors.grey)
          ),
          Text(
            _coupon.hasUnlimitedUses?
              context.l10n.unlimited:
              context.l10n.couponUsesCount(_coupon.remainingUses, _coupon.totalUses),
            style: TextStyles.font14Weight700.copyWith(
              color: Theme.of(context).colorScheme.primary
            )
          )
        ]
      ],
    ),
  );
}
