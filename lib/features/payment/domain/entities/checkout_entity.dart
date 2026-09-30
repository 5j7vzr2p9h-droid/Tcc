import '../../../../core/enums/delivery_method.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';

class CheckoutEntity {
  final DeliveryMethod deliveryMethod;
  final int paymentMethodId;
  final int? addressId;
  final String? coupon, note;
  final List<CartItemEntity> items;

  const new({
    required this.deliveryMethod,
    required this.paymentMethodId,
    required this.items,
    this.addressId,
    this.coupon,
    this.note
  });
}
