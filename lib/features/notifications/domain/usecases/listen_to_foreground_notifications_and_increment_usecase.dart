import 'dart:async';

import '../repositories/notifications_repository.dart';

final class const ListenToForegroundNotificationsAndIncrementUsecase(final NotificationsRepository _repository){
  
  Stream<void> call() => _repository.listenToForegroundNotificationsAndIncrement;
}