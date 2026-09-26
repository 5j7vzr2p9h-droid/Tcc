import 'package:flutter/material.dart';

import '../../config/theming/app_colors.dart';

class ProductPlaceholder extends StatelessWidget {
  const new({super.key});

  @override
  Container build(BuildContext context)
  => Container(
    height: .infinity,
    width: .infinity,
    color: AppColors.of(context).placeHolderBackground,
    child: Icon(
      Icons.restaurant,
      size: 40.0,
      color: AppColors.of(context).placeHolderForeground,
    ),
  );
}