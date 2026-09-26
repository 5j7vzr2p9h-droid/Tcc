import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/legal_list_entity.dart';
import '../../../domain/usecases/get_privacy_policy_usecase.dart';
import 'privacy_policy_state.dart';

final class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState>{
  final GetPrivacyPolicyUsecase _getPrivacyPolicyUsecase;

  new(this._getPrivacyPolicyUsecase): super(const PrivacyPolicyInitialState());

  void init() async{
    emit(const PrivacyPolicyLoadingState());
    (await _getPrivacyPolicyUsecase()).fold(
      (Failure failure) => emit(PrivacyPolicyGetFailureState(failure)) ,
      (LegalListEntity privacyPolicy) => emit(PrivacyPolicyGetSuccessState(privacyPolicy))
    );
  }
}