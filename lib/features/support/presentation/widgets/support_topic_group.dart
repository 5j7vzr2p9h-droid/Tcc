import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';
import 'support_topic_tile.dart';

final class SupportTopicGroup extends StatelessWidget {
  final IconData _icon;
  final String _title;
  final List<SupportTopicTile> _tiles;

  const new({
    super.key,
    required this._icon,
    required this._title,
    required this._tiles
  });

  @override
  Material build(BuildContext context)
  => Material(
    clipBehavior: .antiAlias,
    color: Theme.of(context).colorScheme.surface,
    borderRadius: const .all(.circular(16.0)),
    child: ExpansionTile(
      shape: const Border(),
      collapsedShape: const Border(),
      iconColor: Theme.of(context).colorScheme.primary,
      collapsedIconColor: Theme.of(context).colorScheme.primary,
      leading: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withAlpha(25),
          borderRadius: .circular(12.0)
        ),
        child: Icon(
          _icon,
          color: Theme.of(context).colorScheme.primary
        ),
      ),
      title: Text(
        _title,
        style: TextStyles.font16Weight700
      ),
      children: _tiles,
    ),
  );
}
