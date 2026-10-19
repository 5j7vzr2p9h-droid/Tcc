import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../notifications/domain/usecases/enable_notifications_usecase.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/item_entity.dart';
import '../../../domain/repositories/banners_repository.dart';
import '../../../domain/repositories/categories_repository.dart';
import '../../../domain/usecases/get_popular_products_usecase.dart';
import 'home_state.dart';

final class HomeCubit extends Cubit<HomeState> {
  final CategoriesRepository _categoriesRepository;
  final BannersRepository _bannersRepository;
  final GetPopularProductsUsecase _getPopularProductsUsecase;
  final EnableNotificationsUsecase _enableNotificationsUsecase;

  HomeCubit({
    required this._bannersRepository,
    required this._categoriesRepository,
    required this._getPopularProductsUsecase,
    required this._enableNotificationsUsecase
  }): super(const HomeInitialState());

  void init() async {
  
    emit(const HomeLoadingState());

    final List<Either<Failure, dynamic>> results = await Future.wait([
      _bannersRepository.getBanners(),
      _categoriesRepository.getCategories(),
      _getPopularProductsUsecase(),
      _enableNotificationsUsecase()
    ]);

    final Either<Failure, List<String>> bannersResult = results[0] as Either<Failure, List<String>>;
    final Either<Failure, List<CategoryEntity>> categoriesResult = results[1] as Either<Failure, List<CategoryEntity>>;
    final Either<Failure, List<ItemEntity>> popularProductsResult = results[2] as Either<Failure, List<ItemEntity>>;
  
    if(isClosed)
      return;
    
    bannersResult.fold(
      (Failure failure) => emit(HomeGetFailureState(failure)),
      (List<String> banners) => categoriesResult.fold(
        (Failure failure) => emit(HomeGetFailureState(failure)),
        (List<CategoryEntity> categories) => popularProductsResult.fold(
          (Failure failure) => emit(HomeGetFailureState(failure)),
          (List<ItemEntity> popularItems) => emit(
            HomeGetSuccessState(
              banners: banners,
              categories: categories,
              popularItems: popularItems
            )
          )
        )
      )
    );
  }
}