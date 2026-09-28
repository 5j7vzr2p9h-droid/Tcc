import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../domain/usecases/get_current_orders_usecase.dart';
import 'current_orders_state.dart';

final class CurrentOrdersCubit extends Cubit<CurrentOrdersState>{
  final GetCurrentOrdersUsecase _getCurrentOrdersUsecase;
  
  CurrentOrdersCubit(this._getCurrentOrdersUsecase): super(const CurrentOrdersInitialState());

  List<OrderEntity>? _orders;

  void init() async{
    if(_orders is List<OrderEntity>)
      return emit(CurrentOrdersGetSuccessState(_orders!));
    
    emit(const CurrentOrdersLoadingState());

    (await _getCurrentOrdersUsecase()).fold(
      (Failure failure) {
        emit(CurrentOrdersGetFailureState(failure));
      },
      (List<OrderEntity> orders) {
        emit(CurrentOrdersGetSuccessState(_orders = orders));
      }
    );
  }
}