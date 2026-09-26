import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/notification_entity.dart';
import 'notification_card.dart';

final class NotificationsDaySliver extends StatelessWidget {
  final String _title;
  final List<NotificationEntity> _notifications;

  const new({
    super.key,
    required this._title,
    required this._notifications
  });

  @override
  SliverMainAxisGroup build(BuildContext context)
  => SliverMainAxisGroup(
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Padding(
          padding: const .only(bottom: defaultItemsSeparator),
          child: Text(_title, style: TextStyles.font16Weight700),
        ),
      ),
      SliverList.separated(
        itemCount: _notifications.length,
        separatorBuilder: (BuildContext _, int _) => const SizedBox(height: defaultItemsSeparator),
        itemBuilder: (BuildContext context, int i) => NotificationCard(
          notification: _notifications[i],
          onTap: (){},
        ),
      ),
      const SliverToBoxAdapter(
        child: SizedBox(height: pageContentPadding)
      )
    ],
  );
}
