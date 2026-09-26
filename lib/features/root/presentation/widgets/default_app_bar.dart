import 'package:flutter/material.dart';

import '../../../../core/widgets/handled_network_image.dart';

final class HomeAppBar extends StatelessWidget {
  final String _imageUrl;
  final double _borderRadius;

  const new({
    super.key,
    required this._imageUrl,
    this._borderRadius = 0.0
  });

  @override
  SliverAppBar build(BuildContext context)
  => SliverAppBar(
    shape: RoundedRectangleBorder(
      borderRadius: .circular(_borderRadius)
    ),
    pinned: true,
    expandedHeight: 250.0,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary
      ),
      icon: const Icon(Icons.arrow_back_ios_new)
    ),
    backgroundColor: Theme.of(context).colorScheme.primary,
    flexibleSpace: HandledNetworkImage(
      imageUrl: _imageUrl
    ),
  );
}