import 'package:flutter/material.dart';

final class const DefaultAppBar({
  super.key,
  required final Widget _background,
  final bool _hasBackButton = true,
  }) extends StatelessWidget {

  @override
  SliverAppBar build(BuildContext context)
  => SliverAppBar(
    pinned: true,
    expandedHeight: 250.0,
    leading: _hasBackButton
      ? IconButton(
        onPressed: () => Navigator.pop<void>(context),
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary
        ),
        icon: const Icon(Icons.arrow_back_ios_new)
      )
      : const SizedBox.shrink(),
    backgroundColor: Theme.of(context).colorScheme.primary,
    flexibleSpace: FlexibleSpaceBar(
      background: _background
    ),
  );
}