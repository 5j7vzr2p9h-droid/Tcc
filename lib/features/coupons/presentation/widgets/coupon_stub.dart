import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/coupon_entity.dart';
import 'coupon_background_curve.dart';

final class CouponStub extends StatelessWidget {
  final CouponEntity _coupon;

  const new({
    super.key,
    required this._coupon
  });

  @override
  Stack build(BuildContext context) {
    final Color onColor = Theme.of(context).colorScheme.onPrimary;
    return Stack(
      alignment: .center,
      children: <Widget>[
        Transform.flip(
          flipX: Directionality.of(context) == .rtl,
          child: CustomPaint(
            size: const Size(110, 135.0),
            painter: RPSCustomPainter(_coupon.color),
            willChange: true,
          ),
        ),
        Column(
          mainAxisSize: .min,
          mainAxisAlignment: .center,
          spacing: 4.0,
          children: <Widget>[
            Text(
              _coupon.code,
              textAlign: .center,
              style: TextStyles.font16Weight700.copyWith(color: onColor)
            ),
            if(_coupon.discount case String discount) Text(
              discount,
              style: TextStyles.font24Weight700.copyWith(color: onColor)
            )
            else Icon(
              Icons.local_shipping_outlined,
              size: 28.0,
              color: onColor
            ),
            Text(
              _coupon.isFreeShipping? context.l10n.freeShipping: context.l10n.discount,
              style: TextStyles.font12Weight700.copyWith(color: onColor)
            )
          ],
        ),
      ],
    );
  }
}
