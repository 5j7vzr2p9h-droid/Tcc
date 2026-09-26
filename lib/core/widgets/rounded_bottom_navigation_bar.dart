import 'package:flutter/material.dart';

import '../constants/numerical_values.dart';
import '../extensions/context_l10n.dart';
import '../utils/app_icons.dart';
import '../utils/text_styles.dart';

final class RoundedBottomNavigationBar extends StatelessWidget {
  final ValueNotifier<int> _indexController;
  const new({
    super.key,
    required this._indexController
  });

  @override
  Padding build(BuildContext context)
  => Padding(
    padding: const .only(
      right: pageContentPadding,
      left: pageContentPadding,
      bottom: 16.0
    ),
    child: Container(
      padding: const .symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        shape: const StadiumBorder(),
        shadows: const <BoxShadow>[
          BoxShadow(
            blurRadius: 7.0,
            color: Colors.grey
          )
        ]
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: _indexController,
        builder: (BuildContext context, int currentIndex, Widget? child)
        => Row(
          mainAxisAlignment: .spaceEvenly,
          children: <NavigationBarItem>[
            NavigationBarItem(
              label: context.l10n.home,
              iconData: AppIcons.home,
              index: 0,
              selectedIndex: currentIndex,
              onPressed: () => _indexController.value = 0,
            ),
            NavigationBarItem(
              label: context.l10n.orders,
              iconData: AppIcons.check,
              index: 1,
              selectedIndex: currentIndex,
              onPressed: () => _indexController.value = 1,
            ),
            NavigationBarItem(
              label: context.l10n.notifications,
              iconData: AppIcons.notification,
              index: 2,
              selectedIndex: currentIndex,
              onPressed: () => _indexController.value = 2,
            ),
            NavigationBarItem(
              label: context.l10n.profile,
              iconData: AppIcons.avatar,
              index: 3,
              selectedIndex: currentIndex,
              onPressed: () => _indexController.value = 3,
            ),
          ],
        )
      ),
    ),
  );
}

final class NavigationBarItem extends StatelessWidget {
  final String _label;
  final IconData _iconData;
  final int _index, _selectedIndex;
  final VoidCallback _onPressed;

  const new({
    super.key,
    required this._label,
    required this._iconData,
    required this._index,
    required this._selectedIndex,
    required this._onPressed
  });

  @override
  IconButton build(BuildContext context) {
    final Color color = _index == _selectedIndex? Theme.of(context).colorScheme.primary: Colors.grey;
    return IconButton(
      onPressed: _onPressed,
      style: IconButton.styleFrom(padding: .zero),
      icon: Column(
        mainAxisSize: .min,
        children: <Widget>[
          Icon(
            _iconData,
            color: color,
          ),
          Text(
            _label,
            style: TextStyles.font12Weight400.copyWith(
              color: color
            )
          ),
          Text(
            "•",
            style: TextStyles.font20Weight700.copyWith(
              height: 0.5,
              color: color
            ),
          )
        ],
      ),
    );
  }
}