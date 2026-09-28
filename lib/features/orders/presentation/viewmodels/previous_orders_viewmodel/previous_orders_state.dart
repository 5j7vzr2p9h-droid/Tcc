import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/order_entity.dart';

sealed class const PreviousOrdersState();

final class const PreviousOrdersInitialState() extends PreviousOrdersState;

final class const PreviousOrdersLoadingState() extends PreviousOrdersState;

final class const PreviousOrdersGetSuccessState(
  final List<OrderEntity> orders
) extends PreviousOrdersState;

final class const PreviousOrdersGetFailureState(
  final Failure failure
) extends PreviousOrdersState;