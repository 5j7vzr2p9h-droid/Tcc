import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'core/cache/prefs.dart';
import 'core/constants/cache_keys.dart';
import 'di.dart';

final class LanguageController(super.value) extends ValueNotifier<String>{

  @override
  set value(String langCode){
    getIt<Dio>().options.headers["Accept-Language"] = langCode;
    getIt<Dio>(instanceName: "google_places_dio").options.headers["Accept-Language"] = langCode;
    getIt<Prefs>().setString(key: CacheKeys.language, value: langCode);
    super.value = langCode;
  }
}