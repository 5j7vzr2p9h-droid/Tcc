import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';
import 'settings_tile.dart';

final class SettingsSection extends StatelessWidget {
  final String _title;
  final List<SettingsTile> _tiles;

  const new({
    super.key,
    required this._title,
    required this._tiles
  });

  @override
  Column build(BuildContext context)
  => Column(
    crossAxisAlignment: .start,
    spacing: 8.0,
    children: <Widget>[
      Text(
        _title,
        style: TextStyles.font14Weight700.copyWith(color: Colors.grey)
      ),
      Material(
        clipBehavior: .antiAlias,
        color: Theme.of(context).colorScheme.surface,
        borderRadius: .circular(16.0),
        child: ListView.separated(
          padding: .zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _tiles.length,
          separatorBuilder: (BuildContext context, int _) => Divider(
            height: 0.0,
            indent: 16.0,
            endIndent: 16.0,
            color: Theme.of(context).colorScheme.outline
          ),
          itemBuilder: (BuildContext context, int i) => _tiles[i],
        ),
      )
    ],
  );
}
