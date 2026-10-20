import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/notifications_group.dart';

sealed class const NotificationsState();

final class const NotificationsInitialState() extends NotificationsState;

/// Loading the first page.
final class const NotificationsLoadingState() extends NotificationsState;

/// Failed to load the first page.
final class const NotificationsGetFailureState(
  final Failure failure
) extends NotificationsState;

final class const NotificationsGetSuccessState({
  required final List<NotificationsGroupEntity> groups,
  required final bool hasReachedEnd,
  final bool isLoadingMore = false,
  /// Set when loading the next page failed; the loaded pages stay in [groups].
  final Failure? loadMoreFailure
}) extends NotificationsState;
