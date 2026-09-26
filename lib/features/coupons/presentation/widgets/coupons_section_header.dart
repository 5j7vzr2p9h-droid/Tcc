import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class CouponsSectionHeader extends StatelessWidget {
  final String _title;
  final int _count;
  final bool _isExpired;

  const new({
    super.key,
    required this._title,
    required this._count,
    this._isExpired = false
  });

  @override
  Row build(BuildContext context) {
    final Color indicationColor = _isExpired? Colors.grey: Theme.of(context).colorScheme.primary;
    return Row(
      spacing: 8.0,
      children: <Widget>[
        Text(
          _title,
          style: TextStyles.font16Weight700
        ),
        Container(
          padding: const .symmetric(
            horizontal: 8.0,
            vertical: 2.0
          ),
          decoration: BoxDecoration(
            color: indicationColor.withAlpha(25),
            borderRadius: const .all(.circular(6.0)) 
          ),
          child: Text(
            "$_count",
            style: TextStyles.font12Weight700.copyWith(
              color: indicationColor
            )
          ),
        )
      ],
    );
  }
}
