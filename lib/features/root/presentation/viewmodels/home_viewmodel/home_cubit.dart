import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/item_entity.dart';
import '../../../domain/repositories/categories_repository.dart';
import '../../../domain/usecases/get_popular_products_usecase.dart';
import 'home_state.dart';

final class HomeCubit extends Cubit<HomeState> {
  final CategoriesRepository _categoriesRepository;
  final GetPopularProductsUsecase _getPopularProductsUsecase;

  HomeCubit({
    required this._categoriesRepository,
    required this._getPopularProductsUsecase,
  }): super(const HomeInitialState());

  void init() async {
    if(isClosed) return;
  
    emit(const HomeLoadingState());
  
    final List<Either<Failure, dynamic>> results = await Future.wait([
      _categoriesRepository.getCategories(),
      _getPopularProductsUsecase()
    ]);

    final Either<Failure, List<CategoryEntity>> categoriesResult = results[0] as Either<Failure, List<CategoryEntity>>;
    final Either<Failure, List<ItemEntity>> popularProductsResult = results[1] as Either<Failure, List<ItemEntity>>;
  
    categoriesResult.fold(
      (Failure failure) => emit(HomeGetFailureState(failure)),
      (List<CategoryEntity> categories) => popularProductsResult.fold(
        (Failure failure) => emit(HomeGetFailureState(failure)),
        (List<ItemEntity> popularItems) => emit(
          HomeGetSuccessState(
            categories: categories,
            popularItems: popularItems
          )
        )
      )
    );
  }
}