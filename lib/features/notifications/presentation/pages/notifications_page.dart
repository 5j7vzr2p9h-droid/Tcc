import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/enums/notification_type.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notifications_group.dart';
import '../widgets/no_notifications_placeholder.dart';
import '../widgets/notifications_day_sliver.dart';
import '../widgets/notifications_filter_wrap.dart';

final class NotificationsTab extends StatefulWidget {
  final VoidCallback _onOrdersPressed;

  const new({
    super.key,
    required this._onOrdersPressed
  });

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

final class _NotificationsTabState extends State<NotificationsTab> {
  final ValueNotifier<NotificationType?> _selectedFilter = ValueNotifier<NotificationType?>(null);

  static final DateTime _now = DateTime.now();

  static final List<NotificationsGroupEntity> _groups = <NotificationsGroupEntity>[
    NotificationsGroupEntity(
      date: DateTime.now(),
      notifications: <NotificationEntity>[
        NotificationEntity(
          title: "تم تأكيد طلبك",
          description: "تم تأكيد طلبك رقم #1258 وجاري تحضيره.",
          date: _now.subtract(const Duration(minutes: 10)),
          type: .order,
          isUnread: true
        ),
        NotificationEntity(
          title: "طلبك في الطريق",
          description: "طلبك رقم #1258 في الطريق إليك وسيصلك خلال 15 دقيقة.",
          date: _now.subtract(const Duration(minutes: 25)),
          type: .order,
          isUnread: true
        ),
        NotificationEntity(
          title: "🎉 عرض خاص",
          description: "خصم 20% على جميع الطلبات من اليوم وحتى نهاية الأسبوع!",
          date: _now.subtract(const Duration(hours: 1)),
          type: .offer,
          isUnread: true
        )
      ],
    ),
    NotificationsGroupEntity(
      date: DateTime.now().subtract(const Duration(days: 1)),
      notifications: <NotificationEntity>[
        NotificationEntity(
          title: "تم تسليم طلبك",
          description: "تم تسليم طلبك رقم #1245 بنجاح.",
          date: DateTime(_now.year, _now.month, _now.day - 1, 20, 30),
          type: .order,
        ),
        NotificationEntity(
          title: "تحديث التطبيق",
          description: "تم تحديث التطبيق إلى أحدث إصدار لتحسين تجربتك.",
          date: DateTime(_now.year, _now.month, _now.day - 1, 16, 15),
          type: .update,
        )
      ],
    ),
    NotificationsGroupEntity(
      date: DateTime.now().subtract(const Duration(days: 5)),
      notifications: <NotificationEntity>[
        NotificationEntity(
          title: "👋 اهلاً بك في تطبيقنا",
          description: "ابدأ التسوق الآن واكتشف أفضل العروض.",
          date: DateTime(2024, 5, 20, 11, 0),
          type: .update
        )
      ],
    )
  ];

  @override
  void dispose() {
    _selectedFilter.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(context.l10n.notifications, style: TextStyles.font18Weight700),
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
      actions: <IconButton>[
        IconButton(
          onPressed: () => Navigator.pushNamed(context, Routes.notificationSettings),
          icon: const Icon(Icons.settings)
        )
      ],
    ),
    body: ValueListenableBuilder<NotificationType?>(
      valueListenable: _selectedFilter,
      builder: (BuildContext context, NotificationType? type, Widget? child) {
        final List<NotificationsGroupEntity> groups;
        type == null?
          groups = _groups:
          groups = _groups.map<NotificationsGroupEntity>(
            (NotificationsGroupEntity group){
              final List<NotificationEntity> groupFilteredNotifications = group.notifications.where(
                (NotificationEntity notification) => notification.type == type
              ).toList();
              return NotificationsGroupEntity(
                date: group.date,
                notifications: groupFilteredNotifications
              );
            }
          ).toList();
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            if(groups.isNotEmpty) SliverPadding(
              padding: const .all(pageContentPadding),
              sliver: SliverToBoxAdapter(
                child: NotificationsFilterWrap(selectedFilter: _selectedFilter),
              ),
            ),
            if(groups.isEmpty) SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const .fromLTRB(
                  pageContentPadding,
                  0.0,
                  pageContentPadding,
                  bottomNavigationBarSpace
                ),
                child: NoNotificationsPlaceholder(
                  onOrdersPressed: widget._onOrdersPressed,
                ),
              ),
            )
            else SliverPadding(
              padding: const .fromLTRB(
                pageContentPadding,
                0.0,
                pageContentPadding,
                bottomNavigationBarSpace
              ),
              sliver: SliverMainAxisGroup(
                slivers: <NotificationsDaySliver>[
                  for(final NotificationsGroupEntity group in groups)
                    if(group.notifications.isNotEmpty)
                      NotificationsDaySliver(
                        title: _getNotificationsGroupTitle(context, group.date),
                        notifications: group.notifications,
                      )
                ],
              ),
            )
          ],
        );
      },
    ),
  );

  String _getNotificationsGroupTitle(BuildContext context, DateTime date){
    final DateTime now = DateTime.now();
    final int differenceInDays = now.difference(date).inDays;

    switch(differenceInDays){
      case 0: return context.l10n.today;
      case 1: return context.l10n.yesterday;
    }

    return DateFormat.yMMMd(context.l10n.localeName).format(date);
  }
}
