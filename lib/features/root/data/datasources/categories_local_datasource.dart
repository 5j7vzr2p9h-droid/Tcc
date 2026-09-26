import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/category_model.dart';

abstract interface class CategoriesLocalDatasource {
  void cacheCategories(List<CategoryModel> categories);
  List<CategoryModel> getCachedCategories();
}

final class CategoriesLocalDatasourceImpl implements CategoriesLocalDatasource{
  final Box<CategoryModel> _box;

  const CategoriesLocalDatasourceImpl(this._box);

  @override
  void cacheCategories(List<CategoryModel> categories) {
    _box.clear();
    for(CategoryModel category in categories)
      _box.put(category.id, category);
  }

  @override
  List<CategoryModel> getCachedCategories() {
    final List<CategoryModel> categories = _box.values.toList(); 
    if(categories.isNotEmpty)
      return categories;
    throw const OfflineException();
  }
}