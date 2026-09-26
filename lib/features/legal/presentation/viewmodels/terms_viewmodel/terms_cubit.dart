import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/legal_list_entity.dart';
import '../../../domain/usecases/get_terms_usecase.dart';
import 'terms_state.dart';

final class TermsCubit extends Cubit<TermsState>{
  final GetTermsUsecase _getTermsUsecase;

  new(this._getTermsUsecase): super(const TermsInitialState());

  void init() async{
    emit(const TermsLoadingState());
    (await _getTermsUsecase()).fold(
      (Failure failure) => emit(TermsGetFailureState(failure)) ,
      (LegalListEntity terms) => emit(TermsGetSuccessState(terms))
    );
  }
}