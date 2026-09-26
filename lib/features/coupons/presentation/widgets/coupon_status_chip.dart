import 'package:flutter/material.dart';

import '../../../../core/enums/coupon_status.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class CouponStatusChip extends StatelessWidget {
  final CouponStatus _status;

  const new({
    super.key,
    required this._status
  });

  String _getLabel(BuildContext context) => switch(_status){
    .active => context.l10n.couponActive,
    .expired => context.l10n.couponExpired
  };

  Color _getColor(BuildContext context) => switch(_status){
    .active => Theme.of(context).colorScheme.primary,
    .expired => Colors.grey
  };

  @override
  Container build(BuildContext context) {
    final Color color = _getColor(context);
    return Container(
      padding: const .symmetric(
        horizontal: 12.0,
        vertical: 4.0
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: .circular(8.0)
      ),
      child: Text(
        _getLabel(context),
        style: TextStyles.font12Weight700.copyWith(color: color)
      ),
    );
  }
}
