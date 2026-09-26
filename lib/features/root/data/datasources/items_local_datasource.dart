import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/item_model.dart';

abstract interface class ItemsLocalDatasource {
  void cacheCategoryProducts({
    required int categoryId,
    required List<ItemModel> items
  });
  List<ItemModel> getCachedCategoryProducts(int categoryId);
}

final class ItemsLocalDatasourceImpl implements ItemsLocalDatasource{
  final Box<ItemModel> _box;

  const ItemsLocalDatasourceImpl(this._box);

  @override
  void cacheCategoryProducts({
    required int categoryId,
    required List<ItemModel> items
  }) {
    _box.deleteAll(_itemsKeysOfCategory(categoryId));
    for(ItemModel item in items)
      _box.put(item.id, item);
  }

  @override
  List<ItemModel> getCachedCategoryProducts(int categoryId) {
    final List<ItemModel> items = _box.values
      .where((ItemModel item) => item.categoryId == categoryId).toList();
    if(items.isNotEmpty)
      return items;
    throw const OfflineException();
  }

  List<dynamic> _itemsKeysOfCategory(int categoryId)
  => _box.keys
    .where((dynamic key) => _box.get(key)?.categoryId == categoryId).toList();
}
