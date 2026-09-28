import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/item_entity.dart';
import '../../../domain/usecases/search_products_usecase.dart';
import 'search_state.dart';

final class SearchCubit extends Cubit<SearchState>{
  final SearchProductsUsecase _searchProductsUsecase;

  SearchCubit(this._searchProductsUsecase): super(const SearchInitialState());

  void search(String query) async
  => (await _searchProductsUsecase(query)).fold(
    (Failure failure) => emit(SearchFailureState(
      failure
    )),
    (List<ItemEntity> searchResults) => emit(SearchSuccessState(searchResults))
  );

  void cancel() => emit(const SearchCancelState());
}