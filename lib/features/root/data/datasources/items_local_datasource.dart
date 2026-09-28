import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/item_model.dart';

abstract interface class ItemsLocalDatasource {
  void cacheCategoryProducts({
    required int categoryId,
    required List<ItemModel> items
  });
  List<ItemModel> getCachedCategoryProducts(int categoryId);

  void cachePopularProducts(List<ItemModel> items);
  List<ItemModel> getCachedPopularProducts();
}

final class ItemsLocalDatasourceImpl({
  required final Box<ItemModel> _categoriesItemsBox,
  required final Box<ItemModel> _popularItemsBox
}) implements ItemsLocalDatasource{

  @override
  void cacheCategoryProducts({
    required int categoryId,
    required List<ItemModel> items
  }) {
    _categoriesItemsBox.deleteAll(_itemsKeysOfCategory(categoryId));
    for(ItemModel item in items)
      _categoriesItemsBox.put(item.id, item);
  }

  @override
  List<ItemModel> getCachedCategoryProducts(int categoryId) {
    final List<ItemModel> items = _categoriesItemsBox.values
      .where((ItemModel item) => item.categoryId == categoryId).toList();
    if(items.isNotEmpty)
      return items;
    throw const OfflineException();
  }

  List<dynamic> _itemsKeysOfCategory(int categoryId)
  => _categoriesItemsBox.keys
    .where((dynamic key) => _categoriesItemsBox.get(key)?.categoryId == categoryId).toList();

  @override
  void cachePopularProducts(List<ItemModel> items) {
    _popularItemsBox.clear();
    for(ItemModel item in items)
      _popularItemsBox.put(item.id, item);
  }

  @override
  List<ItemModel> getCachedPopularProducts(){
    final List<ItemModel> items = _popularItemsBox.values.toList();
    if(items.isNotEmpty)
      return items;
    throw const OfflineException();
  }
}
