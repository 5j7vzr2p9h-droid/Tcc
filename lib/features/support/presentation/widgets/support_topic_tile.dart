import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class SupportTopicTile extends StatelessWidget {
  final IconData _icon;
  final String _title;
  final VoidCallback _onTap;

  const new({
    super.key,
    required this._icon,
    required this._title,
    required this._onTap
  });

  @override
  ListTile build(BuildContext context)
  => ListTile(
    onTap: _onTap,
    dense: true,
    leading: Icon(
      _icon,
      size: 20.0,
      color: Theme.of(context).colorScheme.primary
    ),
    title: Text(
      _title,
      style: TextStyles.font14Weight400
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
      size: 14.0,
    ),
  );
}
