import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/errors/failures.dart';
import 'features/auth/domain/usecase/logout_usecase.dart';
import 'features/cart/domain/entities/cart_item_entity.dart';
import 'features/cart/domain/usecases/clear_cart_usecase.dart';

final class AuthCubit extends Cubit<AuthState>{
  final LogoutUsecase _logoutUsecase;
  final ClearCartUsecase _clearCartUsecase;

  AuthCubit({
    required this._logoutUsecase,
    required this._clearCartUsecase
  }): super(const AuthInitialState());

  void unauthenticate() async{
    if(state is UnauthenticateSuccessState)
      return;
    
    if(isClosed)
      return;

    await (await _logoutUsecase()).fold<Future<void>>(
      (Failure failure) async => emit(UnauthenticateFailureState(failure)) ,
      (Unit unit) async => (await _clearCartUsecase()).fold<void>(
        (Failure failure) => emit(UnauthenticateFailureState(failure)),
        (List<CartItemEntity> cartItems) => emit(const UnauthenticateSuccessState())
      )
    );
  }
}

sealed class const AuthState();

final class const AuthInitialState() extends AuthState;

final class const UnauthenticateFailureState(final Failure failure) extends AuthState;

final class const UnauthenticateSuccessState() extends AuthState;