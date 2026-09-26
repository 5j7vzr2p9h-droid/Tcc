import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';

final class const NotificationSettingsPage({super.key}) extends StatefulWidget {

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

final class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _isEnabled = true;

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(context.l10n.notificationSettings),
    ),
    body: Padding(
      padding: const .all(pageContentPadding),
      child: Material(
        clipBehavior: .antiAlias,
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const .all(.circular(16.0)),
        child: SwitchListTile(
          value: _isEnabled,
          onChanged: (bool value) => setState(() => _isEnabled = value),
          secondary: Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withAlpha(25),
              borderRadius: const .all(.circular(12.0))
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: Theme.of(context).colorScheme.primary
            ),
          ),
          title: Text(context.l10n.enableNotifications),
          subtitle: Text(context.l10n.enableNotificationsSubtitle),
        ),
      ),
    ),
  );
}
