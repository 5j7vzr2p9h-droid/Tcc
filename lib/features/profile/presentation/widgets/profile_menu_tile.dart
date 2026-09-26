import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class ProfileMenuTile extends StatelessWidget {
  final IconData _icon;
  final String _title;
  final Color? _color;
  final VoidCallback _onTap;

  const new({
    super.key,
    required this._icon,
    required this._title,
    required this._onTap,
    this._color
  });

  @override
  ListTile build(BuildContext context) {
    final Color color = _color ?? Colors.grey.shade700;
    return ListTile(
      onTap: _onTap,
      leading: Icon(_icon, color: color),
      title: Text(
        _title,
        style: TextStyles.font16Weight700.copyWith(color: color)
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16.0,
        color: Colors.grey
      ),
    );
  }
}
