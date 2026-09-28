import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../root/domain/entities/item_entity.dart';
import '../../../domain/usecases/get_favorites_usecase.dart';
import 'favorites_state.dart';

final class FavoritesCubit extends Cubit<FavoritesState>{
  final GetFavoritesUsecase _getFavoritesUsecase;

  FavoritesCubit(this._getFavoritesUsecase): super(const FavroitesInitialState());

  void init() async{
    emit(const FavoritesLoadingState());

    final Either<Failure, List<ItemEntity>> result = await _getFavoritesUsecase();

    if(isClosed) return;

    result.fold(
      (Failure failure) => emit(FavoritesGetFailureState(failure)),
      (List<ItemEntity> favorites) => emit(FavoritesGetSuccessState(favorites))
    );
  }

  void removeFavorite(int productId){
    if(state case FavoritesGetSuccessState(:final List<ItemEntity> favorites))
      emit(FavoritesGetSuccessState(
        favorites.where((ItemEntity item) => item.id != productId).toList()
      ));
  }
}
