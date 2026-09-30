import 'package:flutter/material.dart';

import '../../../../core/enums/coupon_status.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/coupon_entity.dart';
import 'coupon_background_curve.dart';

final class CouponStub extends StatelessWidget {
  final CouponEntity _coupon;

  const new({
    super.key,
    required this._coupon
  });

  Color get _color => _coupon.status == CouponStatus.expired
    ? Colors.grey
    : switch(_coupon.type){
      .percentage => Colors.deepOrange,
      .fixedAmount => Colors.deepPurple
    };

  IconData get _icon => switch(_coupon.type){
    .percentage => Icons.percent,
    .fixedAmount => Icons.payments_outlined
  };

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
            painter: RPSCustomPainter(_color),
            willChange: true,
          ),
        ),
        SizedBox(
          width: 96.0,
          child: Column(
            mainAxisSize: .min,
            mainAxisAlignment: .center,
            spacing: 4.0,
            children: <Widget>[
              Text(
                _coupon.code,
                textAlign: .center,
                maxLines: 2,
                overflow: .ellipsis,
                style: TextStyles.font16Weight700.copyWith(color: onColor)
              ),
              Icon(
                _icon,
                size: 28.0,
                color: onColor
              ),
              Text(
                _coupon.typeText,
                textAlign: .center,
                maxLines: 2,
                overflow: .ellipsis,
                style: TextStyles.font12Weight700.copyWith(color: onColor)
              )
            ],
          ),
        ),
      ],
    );
  }
}
