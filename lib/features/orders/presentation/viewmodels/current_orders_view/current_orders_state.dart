import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/order_entity.dart';

sealed class const CurrentOrdersState();

final class const CurrentOrdersInitialState() extends CurrentOrdersState;

final class const CurrentOrdersLoadingState() extends CurrentOrdersState;

final class const CurrentOrdersGetSuccessState(
  final List<OrderEntity> orders
) extends CurrentOrdersState;

final class const CurrentOrdersGetFailureState(
  final Failure failure
) extends CurrentOrdersState;