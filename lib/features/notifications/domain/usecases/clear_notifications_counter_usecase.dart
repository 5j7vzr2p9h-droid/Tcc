import '../repositories/notifications_repository.dart';

final class const ClearNotificationsCounterUsecase(final NotificationsRepository _repository){
  
  void call() => _repository.clearNotificatonsCounter();
}