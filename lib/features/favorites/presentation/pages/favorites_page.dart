import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../widgets/favorite_foods_tab.dart';

final class FavoritesPage extends StatelessWidget {
  const new({super.key});

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(context.l10n.favorites, style: TextStyles.font18Weight700),
    ),
    body: const FavoriteFoodsTab(),
  );
}
