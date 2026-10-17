import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/payment_method_entity.dart';

sealed class const PaymentMethodsState();

final class const PaymentMethodsInitialState() extends PaymentMethodsState;

final class const PaymentMethodsLoadingState() extends PaymentMethodsState;

final class const PaymentMethodsGetSuccessState(
  final List<PaymentMethodEntity> methods
) extends PaymentMethodsState;

final class const PaymentMethodsGetFailureState(
  final Failure failure
) extends PaymentMethodsState;
