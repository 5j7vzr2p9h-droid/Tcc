import 'package:flutter/material.dart';

import '../../../../core/enums/order_status.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class OrderStatusChip extends StatelessWidget {
  final OrderStatus _status;

  const new({
    super.key,
    required this._status,
  });

  IconData? get _icon => switch(_status){
    .preparing => Icons.access_time,
    .readyForPickup => Icons.check,
    .completed => Icons.check_circle_outline,
    .cancelled => Icons.cancel,
    .orderSent => Icons.check,
    .delivering => Icons.delivery_dining,
  };

  Color get _color => switch(_status){
    .orderSent => Colors.green,
    .preparing => Colors.orange,
    .completed => Colors.grey,
    .cancelled => Colors.red,
    .readyForPickup => Colors.blue,
    .delivering => Colors.purple
  };

  String _getStatusText(BuildContext context) => switch(_status){
    .preparing => context.l10n.preparing,
    .orderSent => context.l10n.orderSent,
    .readyForPickup => context.l10n.readyForPickup,
    .delivering => context.l10n.delivering,
    .completed => context.l10n.completed,
    .cancelled => context.l10n.cancelled,
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
      borderRadius: const .all(.circular(8.0))
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
          _getStatusText(context),
          style: TextStyles.font12Weight700.copyWith(
            color: _color
          ),
        )
      ],
    ),
  );
}