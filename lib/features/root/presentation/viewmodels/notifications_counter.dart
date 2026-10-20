import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../notifications/domain/usecases/clear_notifications_counter_usecase.dart';
import '../../../notifications/domain/usecases/get_notifications_count_usecase.dart';
import '../../../notifications/domain/usecases/listen_to_foreground_notifications_and_increment_usecase.dart';

final class NotificationsCounter extends ValueNotifier<int>{
  final GetNotificationsCountUsecase _getNotificationsCountUsecase;
  final ListenToForegroundNotificationsAndIncrementUsecase _listenToForegroundNotificationsAndIncrementUsecase;
  final ClearNotificationsCounterUsecase _clearNotificationsCounterUsecase;

  late final StreamSubscription<void> _counterListener;

  NotificationsCounter({
    required this._getNotificationsCountUsecase,
    required this._listenToForegroundNotificationsAndIncrementUsecase,
    required this._clearNotificationsCounterUsecase
  }): super(0);
  
  void init() {
    value = _getNotificationsCountUsecase();
    _counterListener = _listenToForegroundNotificationsAndIncrementUsecase().listen(
      (void _) => value++
    );
  }

  void clear() => _clearNotificationsCounterUsecase();

  @override
  void dispose(){
    _counterListener.cancel();
    super.dispose();
  }
}