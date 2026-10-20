import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../notifications/domain/usecases/enable_notifications_usecase.dart';
import '../../../domain/entities/branch_entity.dart';
import '../../../domain/usecases/get_branch_usecase.dart';
import 'request_location_permession_state.dart';

final class RequestLocationPermessionCubit extends Cubit<RequestLocationPermessionState>{
  final GetBranchUsecase _getBranchUsecase;
  final EnableNotificationsUsecase _enableNotificationsUsecase;

  RequestLocationPermessionCubit({
    required this._getBranchUsecase,
    required this._enableNotificationsUsecase
  }): super(const RequestLocationPermessionInitialState());

  void requestLocation() async{
    emit(const RequestLocationPermessionLoadingState());

    final Either<Failure, BranchEntity> result = await _getBranchUsecase();

    if(isClosed)
      return;
    
    result.fold<void>(
      (Failure failure) => emit(RequestLocationPermessionFailureState(failure)), 
      (BranchEntity branch) async{
        await _enableNotificationsUsecase();
        emit(RequestLocationPermessionSuccessState(branch));
      }
    );
  }
}