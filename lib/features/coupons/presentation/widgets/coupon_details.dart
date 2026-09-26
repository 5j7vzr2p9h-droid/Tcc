import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/coupon_status.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/icon_label.dart';
import '../../domain/entities/coupon_entity.dart';

final class CouponDetails extends StatelessWidget {
  final CouponEntity _coupon;

  const new({
    super.key,
    required this._coupon
  });

  @override
  Column build(BuildContext context) {
    final String date = DateFormat.yMMMd(context.l10n.localeName).format(_coupon.expiryDate);
    return Column(
      crossAxisAlignment: .start,
      mainAxisAlignment: .center,
      spacing: 4.0,
      children: <Widget>[
        Text(
          _coupon.title,
          style: TextStyles.font14Weight700
        ),
        Text(
          context.l10n.couponMinimumOrder(_coupon.minimumOrder),
          style: TextStyles.font12Weight400.copyWith(color: Colors.grey)
        ),
        IconLabel(
          icon: Icons.calendar_month_outlined,
          label: _coupon.status == CouponStatus.active?
            context.l10n.couponExpiresOn(date):
            context.l10n.couponExpiredOn(date)
        )
      ],
    );
  }
}
