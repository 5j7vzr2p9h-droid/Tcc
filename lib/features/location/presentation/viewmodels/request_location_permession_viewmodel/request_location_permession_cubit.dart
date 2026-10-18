import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/branch_entity.dart';
import '../../../domain/usecases/get_branch_usecase.dart';
import 'request_location_permession_state.dart';

final class RequestLocationPermessionCubit extends Cubit<RequestLocationPermessionState>{
  final GetBranchUsecase _getBranchUsecase;

  RequestLocationPermessionCubit(this._getBranchUsecase): super(const RequestLocationPermessionInitialState());

  void requestLocation() async{
    final Either<Failure, BranchEntity> result = await _getBranchUsecase();

    if(isClosed)
      return;
    
    result.fold(
      (Failure failure) => emit(RequestLocationPermessionFailureState(failure)), 
      (BranchEntity branch) => emit(RequestLocationPermessionSuccessState(branch))
    );
  }
}