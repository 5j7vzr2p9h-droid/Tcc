import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/legal_list_entity.dart';

sealed class const TermsState();

final class const TermsInitialState() extends TermsState;

final class const TermsLoadingState() extends TermsState;

final class const TermsGetSuccessState(
  final LegalListEntity terms
) extends TermsState;

final class const TermsGetFailureState(
  final Failure failure
) extends TermsState;