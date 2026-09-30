import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/payment_method_entity.dart';

sealed class const PaymentMethodsState();

final class const PaymentMethodsInitialState() extends PaymentMethodsState;

final class const PaymentMethodsLoadingState() extends PaymentMethodsState;

final class const PaymentMethodsGetSuccessState({
  required final List<PaymentMethodEntity> methods,
  required final double balance
}) extends PaymentMethodsState;

final class const PaymentMethodsGetFailureState(
  final Failure failure
) extends PaymentMethodsState;
