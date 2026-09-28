import '../../../../core/enums/order_status.dart';

class OrderEntity {
  final int id;
  final DateTime date;
  final double total;
  final String deliveyAddress, image, statusText;
  final OrderStatus status;

  const new({
    required this.id,
    required this.date,
    required this.total,
    required this.deliveyAddress,
    required this.image,
    required this.status,
    required this.statusText
  });
}
