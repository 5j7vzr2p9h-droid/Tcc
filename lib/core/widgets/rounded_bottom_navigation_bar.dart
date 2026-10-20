import 'package:flutter/material.dart';

import '../../features/root/presentation/viewmodels/notifications_counter.dart';
import '../constants/numerical_values.dart';
import '../extensions/context_l10n.dart';
import '../utils/app_icons.dart';
import '../utils/text_styles.dart';

final class const RoundedBottomNavigationBar({
  super.key,
  required final ValueNotifier<int> _indexController,
  required final NotificationsCounter _notificationsCounter
}) extends StatelessWidget {

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
              notificationsCounter: _notificationsCounter,
              label: context.l10n.notifications,
              iconData: AppIcons.notification,
              index: 2,
              selectedIndex: currentIndex,
              onPressed: () {
                _indexController.value = 2;
                _notificationsCounter.clear();
              },
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

final class const NavigationBarItem({
  super.key,
  final ValueNotifier<int>? _notificationsCounter,
  required final String _label,
  required final IconData _iconData,
  required final int _index,
  required final int _selectedIndex,
  required final VoidCallback _onPressed
}) extends StatelessWidget {
  

  @override
  IconButton build(BuildContext context) {
    final Color color = _index == _selectedIndex? Theme.of(context).colorScheme.primary: Colors.grey;
    return IconButton(
      onPressed: _onPressed,
      style: IconButton.styleFrom(padding: .zero),
      icon: Column(
        mainAxisSize: .min,
        children: <Widget>[
          _notificationsCounter is ValueNotifier<int>
            ? ValueListenableBuilder<int>(
              valueListenable: _notificationsCounter,
              builder: (BuildContext context, int count, Widget? child)
              => Badge.count(
                isLabelVisible: count>0,
                count: count,
                child: child,
              ),
              child: Icon(
                _iconData,
                color: color,
              ),
            )
            : Icon(
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