import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/notifications_repository.dart';

final class const EnableNotificationsUsecase(final NotificationsRepository _repository){
  
  Future<Either<Failure, Unit>> call()
  => _repository.enableNotifications();
}