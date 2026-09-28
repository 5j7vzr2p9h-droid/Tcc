import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../domain/usecases/get_previous_orders_usecase.dart';
import 'previous_orders_state.dart';

final class PreviousOrdersCubit extends Cubit<PreviousOrdersState>{
  final GetPreviousOrdersUsecase _getPreviousOrdersUsecase;
  
  PreviousOrdersCubit(this._getPreviousOrdersUsecase): super(const PreviousOrdersInitialState());

  List<OrderEntity>? _orders;

  void init() async{
    if(_orders is List<OrderEntity>)
      return emit(PreviousOrdersGetSuccessState(_orders!));
    
    emit(const PreviousOrdersLoadingState());

    if(isClosed)
      return;
    
    (await _getPreviousOrdersUsecase()).fold(
      (Failure failure) {
        emit(PreviousOrdersGetFailureState(failure));
      },
      (List<OrderEntity> orders) => emit(PreviousOrdersGetSuccessState(_orders = orders))
    );
  }
}