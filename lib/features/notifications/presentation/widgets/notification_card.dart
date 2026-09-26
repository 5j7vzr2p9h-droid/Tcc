import 'package:electronic_menu/core/enums/notification_type.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/notification_entity.dart';

final class NotificationCard extends StatelessWidget {
  final NotificationEntity _notification;
  final VoidCallback _onTap;

  const new({
    super.key,
    required this._notification,
    required this._onTap
  });

  @override
  Material build(BuildContext context)
  => Material(
    color: Theme.of(context).colorScheme.surface,
    clipBehavior: .antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(
      borderRadius: .circular(16.0),
      side: BorderSide(color: Theme.of(context).colorScheme.outline)
    ),
    child: InkWell(
      onTap: _onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: .start,
          spacing: 12.0,
          children: <Widget>[
            Container(
              width: 48.0,
              height: 48.0,
              alignment: .center,
              decoration: BoxDecoration(
                shape: .circle,
                color: _getNotificationIconAndColor(context).value.withAlpha(30)
              ),
              child: Icon(
                _getNotificationIconAndColor(context).key,
                color: _getNotificationIconAndColor(context).value
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 4.0,
                children: <Widget>[
                  Text(
                    _notification.title,
                    style: TextStyles.font14Weight700
                  ),
                  Text(
                    _notification.description,
                    style: TextStyles.font12Weight400.copyWith(
                      color: Colors.grey
                    )
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: .end,
              spacing: 8.0,
              children: <Widget>[
                Row(
                  mainAxisSize: .min,
                  spacing: 4.0,
                  children: <Widget>[
                    if(_notification.isUnread) Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        shape: .circle,
                        color: Theme.of(context).colorScheme.primary
                      ),
                    ),
                    Text(
                      DateFormatter.formatDate(context, _notification.date),
                      style: TextStyles.font12Weight400.copyWith(
                        color: Colors.grey
                      )
                    )
                  ],
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 18.0,
                  color: Colors.grey
                )
              ],
            )
          ],
        ),
      ),
    ),
  );

  MapEntry<IconData, Color> _getNotificationIconAndColor(BuildContext context)
  => switch(_notification.type){
    NotificationType.order => const MapEntry<IconData, Color>(Icons.zoom_out_outlined, Colors.green),
    NotificationType.offer => MapEntry<IconData, Color>(Icons.badge, Theme.of(context).colorScheme.primary),
    NotificationType.update => const MapEntry<IconData, Color>(Icons.system_update, Colors.blue),
  };
}
