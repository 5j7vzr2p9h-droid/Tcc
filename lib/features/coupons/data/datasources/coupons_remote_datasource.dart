import 'dart:math';

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../root/domain/entities/item_entity.dart';
import '../models/coupon_model.dart';
import '../models/coupon_quote_model.dart';

abstract interface class const CouponsRemoteDatasource() {
  Future<List<CouponModel>> getCoupons(int branchId);
  Future<CouponQuoteModel> applyCoupon({
    required int branchId,
    required String code,
    required List<CartItemEntity> items
  });
}

final class const CouponsRemoteDatasourceImpl(final Dio _dio) implements CouponsRemoteDatasource{
  @override
  Future<List<CouponModel>> getCoupons(int branchId) async{
    try{
      final Response response = await _dio.get(
        ApiEndpoints.coupons,
        queryParameters: <String, int>{
          "branchId": branchId
        }
      );
      final List<CouponModel> coupons = ((response.data["data"] as List?) ?? const [])
        .map<CouponModel>((json) => CouponModel.fromJson(json)).toList();
      return coupons;
    } on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }

  /// The backend quotes the coupon against the whole cart, so it takes the checkout body.
  @override
  Future<CouponQuoteModel> applyCoupon({
    required int branchId,
    required String code,
    required List<CartItemEntity> items
  }) async{
    try{
      final Response response = await _dio.post(
        ApiEndpoints.applyCoupon,
        data: <String, dynamic>{
          "requestId": _generateRequestId(),
          "branchId": branchId,
          "coupon": code,
          "items": items.map<Map<String, dynamic>>(_toCheckoutLine).toList()
        }
      );
      return CouponQuoteModel.fromJson(response.data);
    } on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }

  static Map<String, dynamic> _toCheckoutLine(CartItemEntity item)
  => <String, dynamic>{
    "productId": item.productId,
    "quantity": item.quantity,
    "sizeId": item.size?.id,
    "addons": item.addons.map<Map<String, int>>((AddonEntity addon) => <String, int>{
      "addonId": addon.id,
      "quantity": 1
    }).toList(),
    "note": item.notes.trim().isEmpty ? null : item.notes.trim()
  };

  static String _generateRequestId(){
    final Random random = Random.secure();
    return List<String>.generate(32, (int _) => random.nextInt(16).toRadixString(16)).join();
  }
}
