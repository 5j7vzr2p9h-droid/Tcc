import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/item_entity.dart';
import '../../../domain/usecases/get_category_products_usecase.dart';
import 'category_items_state.dart';

final class CategoryProductsCubit extends Cubit<CategoryProductsState>{
  final GetCategoryProductsUsecase _getCategoryProductsUsecase;
  
  new(this._getCategoryProductsUsecase): super(const CategoryProductsInitialState());

  void getCategoryProducts(int categoryId) async{
    emit(const CategoryProductsLoadingState());
    if(!isClosed)
      (await _getCategoryProductsUsecase(categoryId)).fold(
        (Failure failure) => emit(CategoryProductsGetFailureState(failure)),
        (List<ItemEntity> products) => emit(CategoryProductsGetSuccessState(products))
      );
  }
}