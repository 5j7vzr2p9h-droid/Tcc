import 'package:flutter/material.dart';

final class FavoriteButton extends StatelessWidget {
  final VoidCallback _onTap;

  const new(this._onTap, {super.key});

  @override
  IconButton build(BuildContext context)
  => IconButton(
    onPressed: _onTap,
    color: Theme.of(context).colorScheme.primary,
    icon: const Icon(Icons.favorite)
  );
}