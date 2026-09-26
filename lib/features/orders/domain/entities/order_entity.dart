import '../../../../core/enums/order_status.dart';

final class OrderEntity {
  final String number, address, image;
  final DateTime date;
  final double total;
  final OrderStatus status;

  const new({
    required this.number,
    required this.address,
    required this.image,
    required this.date,
    required this.total,
    required this.status
  });
}
