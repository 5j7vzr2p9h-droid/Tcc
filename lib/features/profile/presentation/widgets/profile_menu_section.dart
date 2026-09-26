import 'package:flutter/material.dart';

import 'profile_menu_tile.dart';

final class ProfileMenuSection extends StatelessWidget {
  final List<ProfileMenuTile> _tiles;

  const new({
    super.key,
    required this._tiles
  });

  @override
  Material build(BuildContext context)
  => Material(
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
  );
}
