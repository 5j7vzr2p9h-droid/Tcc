import '../repositories/notifications_repository.dart';

final class const IncrementNotificationsCountUsecase(final NotificationsRepository _repository){
  
  void call() => _repository.incrementNotificationsCounter();
}