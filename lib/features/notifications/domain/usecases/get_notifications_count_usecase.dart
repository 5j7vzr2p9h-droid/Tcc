import '../repositories/notifications_repository.dart';

final class const GetNotificationsCountUsecase(final NotificationsRepository _repository){
  
  int call() => _repository.notificationsCount;
}