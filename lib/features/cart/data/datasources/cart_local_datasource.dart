import 'package:hive_flutter/hive_flutter.dart';

import '../models/cart_item_model.dart';

abstract interface class CartLocalDatasource {
  List<CartItemModel> getCartItems();
  CartItemModel? getCartItem(String key);
  Future<void> saveCartItem(CartItemModel item);
  Future<void> deleteCartItem(String key);
  Future<void> clearCart();
}

final class const CartLocalDatasourceImpl(
  final Box<Map> _box
) implements CartLocalDatasource{

  @override
  List<CartItemModel> getCartItems()
  => _box.values.map<CartItemModel>(CartItemModel.fromJson).toList()
    ..sort((CartItemModel a, CartItemModel b) => a.addedAt.compareTo(b.addedAt));

  @override
  CartItemModel? getCartItem(String key){
    final Map? json = _box.get(key);
    return json == null ? null : CartItemModel.fromJson(json);
  }

  @override
  Future<void> saveCartItem(CartItemModel item)
  => _box.put(item.key, item.toJson());

  @override
  Future<void> deleteCartItem(String key)
  => _box.delete(key);

  @override
  Future<void> clearCart()
  => _box.clear();
}
