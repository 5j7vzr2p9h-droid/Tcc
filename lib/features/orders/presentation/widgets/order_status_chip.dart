import 'package:flutter/material.dart';

import '../../../../core/enums/order_status.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class OrderStatusChip extends StatelessWidget {
  final OrderStatus _status;

  const new({
    super.key,
    required this._status
  });

  String _getLabel(BuildContext context) => switch(_status){
    .preparing => context.l10n.preparing,
    .delivered => context.l10n.delivered,
    .received => context.l10n.orderReceived,
    .completed => context.l10n.completed
  };

  IconData? get _icon => switch(_status){
    .preparing => Icons.access_time,
    .delivered => Icons.check,
    .received => Icons.check_circle_outline,
    .completed => null
  };

  Color get _color => switch(_status){
    .preparing => Colors.orange,
    .delivered => Colors.blue,
    .received => Colors.green,
    .completed => Colors.grey
  };

  @override
  Container build(BuildContext context)
  => Container(
    padding: const .symmetric(
      horizontal: 12.0,
      vertical: 6.0
    ),
    decoration: BoxDecoration(
      color: _color.withValues(alpha: 0.12),
      borderRadius: .circular(8.0)
    ),
    child: Row(
      mainAxisSize: .min,
      spacing: 4.0,
      children: <Widget>[
        if(_icon case IconData icon) Icon(
          icon,
          size: 16.0,
          color: _color
        ),
        Text(
          _getLabel(context),
          style: TextStyles.font12Weight700.copyWith(
            color: _color
          ),
        )
      ],
    ),
  );
}
