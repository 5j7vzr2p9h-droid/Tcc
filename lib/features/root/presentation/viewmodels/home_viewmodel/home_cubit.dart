import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/repositories/categories_repository.dart';
import 'home_state.dart';

final class HomeCubit extends Cubit<HomeState> {
  final CategoriesRepository _categoriesRepository;

  HomeCubit(this._categoriesRepository): super(const HomeInitialState());

  void init() async {
    emit(const HomeLoadingState());
    (await _categoriesRepository.getCategories()).fold(
      (Failure failure) => emit(HomeGetFailureState(failure)),
      (List<CategoryEntity> categories) => emit(HomeGetSuccessState(categories: categories))
    );
  }
}