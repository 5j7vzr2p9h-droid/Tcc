import 'package:flutter/material.dart';

import 'core/cache/prefs.dart';
import 'core/constants/cache_keys.dart';
import 'di.dart';

final class ThemeController(super.value) extends ValueNotifier<ThemeMode>{

  @override
  set value(ThemeMode themeMode){
    getIt<Prefs>().setString(key: CacheKeys.theme, value: themeMode.name);
    super.value = themeMode;
  }
}
