import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/handled_network_image.dart';
import 'banners_slider.dart';

final class const DefaultAppBar({
  super.key,
  required final Widget _background,
  final IconButton? _leading
  }) extends StatelessWidget {

  @override
  SliverAppBar build(BuildContext context)
  => SliverAppBar(
    pinned: true,
    expandedHeight: 250.0,
    leading: _leading ?? IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary
      ),
      icon: const Icon(Icons.arrow_back_ios_new)
    ),
    
    backgroundColor: Theme.of(context).colorScheme.primary,
    flexibleSpace: FlexibleSpaceBar(
      background: _background
    )
  );
}