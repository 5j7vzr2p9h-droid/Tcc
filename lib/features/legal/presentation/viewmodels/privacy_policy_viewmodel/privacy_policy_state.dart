import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/legal_list_entity.dart';

sealed class const PrivacyPolicyState();

final class const PrivacyPolicyInitialState() extends PrivacyPolicyState;

final class const PrivacyPolicyLoadingState() extends PrivacyPolicyState;

final class const PrivacyPolicyGetSuccessState(
  final LegalListEntity privacyPolicy
) extends PrivacyPolicyState;

final class const PrivacyPolicyGetFailureState(
  final Failure failure
) extends PrivacyPolicyState;