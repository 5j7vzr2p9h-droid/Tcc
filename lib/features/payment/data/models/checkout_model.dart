import '../../../cart/data/models/cart_item_model.dart';
import '../../domain/entities/checkout_entity.dart';

final class CheckoutModel extends CheckoutEntity{
  final int branchId;

  const new({
    required super.deliveryMethod,
    required super.paymentMethodId,
    required super.items,
    required super.addressId,
    required super.coupon,
    required super.note,
    required this.branchId
  });

  factory CheckoutModel.fromEntity(CheckoutEntity checkout, {required int branchId})
  => CheckoutModel(
    deliveryMethod: checkout.deliveryMethod,
    paymentMethodId: checkout.paymentMethodId,
    items: checkout.items,
    addressId: checkout.addressId,
    coupon: checkout.coupon,
    note: checkout.note,
    branchId: branchId
  );

  /// Everything except the requestId, so two attempts can be compared to know if they're the same order.
  Map<String, dynamic> toJson()
  => <String, dynamic>{
    "branchId": branchId,
    "deliveryMethod": deliveryMethod.index + 1, // 1 for delivery, 2 for pickup.
    "addressId": ?addressId,
    "paymentMethodId": paymentMethodId,
    "coupon": ?_nullIfBlank(coupon),
    "note": ?_nullIfBlank(note),
    "items": items.map<Map<String, dynamic>>(CartItemModel.toCheckoutLine).toList()
  };

  static String? _nullIfBlank(String? value)
  => value == null || value.trim().isEmpty ? null : value.trim();
}
