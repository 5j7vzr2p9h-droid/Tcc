import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

final class IconLabel extends StatelessWidget {
  final IconData _icon;
  final String _label;
  final Color? _color;
  final TextStyle? _style;
  final double _iconSize;

  const new({
    super.key,
    required this._icon,
    required this._label,
    this._color,
    this._style,
    this._iconSize = 16.0
  });

  @override
  Row build(BuildContext context) {
    final Color color = _color ?? Colors.grey;
    return Row(
      mainAxisSize: .min,
      spacing: 4.0,
      children: <Widget>[
        Icon(_icon, size: _iconSize, color: color),
        Flexible(
          child: Text(
            _label,
            overflow: .ellipsis,
            style: (_style ?? TextStyles.font12Weight400).copyWith(color: color)
          ),
        )
      ],
    );
  }
}
