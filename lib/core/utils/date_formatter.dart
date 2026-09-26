import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../extensions/context_l10n.dart';

abstract final class DateFormatter{
  static String formatDate(BuildContext context, DateTime date, {bool isShort = false}){
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);

    if (isShort) {
      switch (difference.inDays) {
        case 0:
          return context.l10n.today;
        case 1:
          return context.l10n.yesterday;
      }

      return DateFormat.yMMMd(context.l10n.localeName).format(date);
    }


    if (difference.inMinutes < 1) return context.l10n.now;
    if (difference.inMinutes < 60) {
      return _relative(context, difference.inMinutes, context.l10n.minute, context.l10n.twoMinutes, context.l10n.minutes);
    }
    if (difference.inHours < 12) {
      return _relative(context, difference.inHours, context.l10n.hour, context.l10n.twoHours, context.l10n.hours);
    }

    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime day = DateTime(date.year, date.month, date.day);
    final int differenceInDays = today.difference(day).inDays;

    switch (differenceInDays) {
      case 0:
        return "${context.l10n.today} ${DateFormat.jm(context.l10n.localeName).format(date)}";
      case 1:
        return "${context.l10n.yesterday} ${DateFormat.jm(context.l10n.localeName).format(date)}";
    }

    return DateFormat.yMMMd(context.l10n.localeName).add_jm().format(date);
  }

  static String _relative(BuildContext context, int count, String singular, String dual, String plural) {
    if (count == 1) return context.l10n.timeAgo(singular);
    if (count == 2) return context.l10n.timeAgo(dual);
    if (count <= 10) return context.l10n.timeAgo("$count $plural");

    return context.l10n.timeAgo("$count $singular");
  }
}