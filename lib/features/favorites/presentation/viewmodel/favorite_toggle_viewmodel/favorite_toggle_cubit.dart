import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usecases/toggle_favorite_usecase.dart';
import 'favorite_toggle_state.dart';

final class FavoriteToggleCubit extends Cubit<FavoriteToggleState>{
  final ToggleFavoriteUsecase _toggleFavoriteUsecase;
  final int _productId;

  FavoriteToggleCubit({
    required this._toggleFavoriteUsecase,
    required this._productId,
    required bool isFavorite
  }): super(FavoriteToggleIdleState(isFavorite));

  void toggle() async{
    if(state is FavoriteToggleLoadingState) return;

    final bool newValue = !state.isFavorite;

    // Optimistic update, reverted on failure.
    emit(FavoriteToggleLoadingState(newValue));

    final Either<Failure, Unit> result = await _toggleFavoriteUsecase(_productId, newValue);

    if(isClosed) return;

    result.fold(
      (Failure failure) => emit(FavoriteToggleFailureState(!newValue, failure)),
      (Unit _) => emit(FavoriteToggleSuccessState(newValue))
    );
  }
}
