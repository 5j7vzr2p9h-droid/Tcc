import 'package:flutter/material.dart';

import '../../../../core/enums/notification_type.dart';
import '../../../../core/extensions/context_l10n.dart';
import 'notification_filter_chip.dart';

final class NotificationsFilterWrap extends StatelessWidget {
  /// A null type means that no filter is applied.

  final ValueNotifier<NotificationType?> _selectedFilter;

  const new({
    super.key,
    required this._selectedFilter
  });

  @override
  ValueListenableBuilder<NotificationType?> build(BuildContext context)
  => ValueListenableBuilder<NotificationType?>(
    valueListenable: _selectedFilter,
    builder: (BuildContext context, NotificationType? selected, Widget? child) {
      final Map<String, NotificationType?> filters =
       <String, NotificationType?>{
        context.l10n.all: null,
        context.l10n.offers: .offer,
        context.l10n.orders: .order,
        context.l10n.updates: .update
      };
      return Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: <NotificationFilterChip>[
          for(final MapEntry<String, NotificationType?> filter in filters.entries)
            NotificationFilterChip(
              label: filter.key,
              selected: selected == filter.value,
              onPressed: () => _selectedFilter.value = filter.value,
            )
        ],
      );
    },
  );
}
