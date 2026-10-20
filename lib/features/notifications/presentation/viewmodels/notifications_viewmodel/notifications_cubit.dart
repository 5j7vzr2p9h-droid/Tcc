import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/entities/paginated_list_entity.dart';
import '../../../../../core/enums/notification_type.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/notification_entity.dart';
import '../../../domain/entities/notifications_group.dart';
import '../../../domain/usecases/get_notifications_usecase.dart';
import 'notifications_state.dart';

final class NotificationsCubit extends Cubit<NotificationsState>{
  final GetNotificationsUsecase _getNotificationsUsecase;

  NotificationsCubit(this._getNotificationsUsecase): super(const NotificationsInitialState());

  static const int _firstPageIndex = 0, _pageSize = 20;

  NotificationType? _type;
  int _nextPageIndex = _firstPageIndex;
  List<NotificationEntity> _notifications = <NotificationEntity>[];

  /// Bumped on every [init] so responses of a previous filter are dropped.
  int _generation = 0;

  /// Loads the first page, filtered by [type] (null means all types).
  Future<void> init({NotificationType? type}) async{
    final int generation = ++_generation;
    _type = type;
    _nextPageIndex = _firstPageIndex;
    _notifications = <NotificationEntity>[];

    emit(const NotificationsLoadingState());

    final Either<Failure, PaginatedListEntity<NotificationEntity>> result = await _fetchNextPage();

    if(isClosed || generation != _generation)
      return;

    result.fold(
      (Failure failure) => emit(NotificationsGetFailureState(failure)),
      _onPageLoaded
    );
  }

  /// Loads the next page. Does nothing while a page is loading or after the last one,
  /// and after a failed attempt unless [retry] is set, so scrolling can't spin on a failing request.
  Future<void> loadMore({bool retry = false}) async{
    final NotificationsState currentState = state;
    if(currentState is! NotificationsGetSuccessState || currentState.hasReachedEnd
      || currentState.isLoadingMore || (currentState.loadMoreFailure != null && !retry))
      return;

    final int generation = _generation;

    emit(
      NotificationsGetSuccessState(
        groups: currentState.groups,
        hasReachedEnd: false,
        isLoadingMore: true
      )
    );

    final Either<Failure, PaginatedListEntity<NotificationEntity>> result = await _fetchNextPage();

    if(isClosed || generation != _generation)
      return;

    result.fold(
      (Failure failure) => emit(
        NotificationsGetSuccessState(
          groups: currentState.groups,
          hasReachedEnd: false,
          loadMoreFailure: failure
        )
      ),
      _onPageLoaded
    );
  }

  Future<Either<Failure, PaginatedListEntity<NotificationEntity>>> _fetchNextPage()
  => _getNotificationsUsecase(
    pageIndex: _nextPageIndex,
    pageSize: _pageSize,
    type: _type
  );

  void _onPageLoaded(PaginatedListEntity<NotificationEntity> page){
    _nextPageIndex++;
    _notifications = <NotificationEntity>[..._notifications, ...page.items];

    emit(
      NotificationsGetSuccessState(
        groups: _groupByDay(_notifications),
        hasReachedEnd: page.items.isEmpty || _notifications.length >= page.count
      )
    );
  }

  /// Expects [notifications] sorted by date, newest first.
  static List<NotificationsGroupEntity> _groupByDay(List<NotificationEntity> notifications){
    final List<NotificationsGroupEntity> groups = <NotificationsGroupEntity>[];

    for(final NotificationEntity notification in notifications){
      final DateTime day = DateTime(notification.date.year, notification.date.month, notification.date.day);

      if(groups.lastOrNull?.date == day)
        groups.last.notifications.add(notification);
      else
        groups.add(
          NotificationsGroupEntity(
            date: day,
            notifications: <NotificationEntity>[notification]
          )
        );
    }

    return groups;
  }
}
