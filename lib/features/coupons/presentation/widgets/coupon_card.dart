import 'package:flutter/material.dart';

import '../../../../core/enums/coupon_status.dart';
import '../../domain/entities/coupon_entity.dart';
import 'copy_code_button.dart';
import 'coupon_details.dart';
import 'coupon_stub.dart';
import 'coupon_usage.dart';

final class CouponCard extends StatelessWidget {
  final CouponEntity _coupon;

  const new({
    super.key,
    required this._coupon
  });

  @override
  Material build(BuildContext context)
  => Material(
    clipBehavior: .antiAliasWithSaveLayer,
    color: Theme.of(context).colorScheme.surface,
    borderRadius: const .all(.circular(16.0)),
    child: Column(
      children: <Widget>[
        IntrinsicHeight(
          child: Row(
            children: <Widget>[
              CouponStub(coupon: _coupon),
              Expanded(
                child: Padding(
                  padding: const .all(4.0),
                  child: CouponDetails(coupon: _coupon),
                ),
              ),
              VerticalDivider(
                width: 0.0,
                indent: 12.0,
                endIndent: 12.0,
                color: Theme.of(context).colorScheme.outline
              ),
              CouponUsage(coupon: _coupon)
            ],
          ),
        ),
        if(_coupon.status == CouponStatus.active) CopyCodeButton(code: _coupon.code)
      ],
    ),
  );
}
