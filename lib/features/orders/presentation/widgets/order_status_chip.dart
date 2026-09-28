import 'package:flutter/material.dart';

import '../../../../core/enums/order_status.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class OrderStatusChip extends StatelessWidget {
  final OrderStatus _status;
  final String _statusText;

  const new({
    super.key,
    required this._status,
    required this._statusText
  });

  IconData? get _icon => switch(_status){
    .held => Icons.access_time,
    .paid => Icons.check,
    .sentToKitchen => Icons.check_circle_outline,
    .cancelled => null
  };

  Color get _color => switch(_status){
    .held => Colors.orange,
    .paid => Colors.blue,
    .sentToKitchen => Colors.green,
    .cancelled => Colors.grey
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
          _statusText,
          style: TextStyles.font12Weight700.copyWith(
            color: _color
          ),
        )
      ],
    ),
  );
}
