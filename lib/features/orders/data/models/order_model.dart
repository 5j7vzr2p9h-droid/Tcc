import '../../../../core/enums/order_status.dart';
import '../../domain/entities/order_entity.dart';

final class const OrderModel({
  required super.id,
  required super.date,
  required super.total,
  required super.deliveyAddress,
  required super.image,
  required super.statusText,
  required super.status,
}) extends OrderEntity{

  factory OrderModel.fromJson(dynamic json)
  => OrderModel(
    id: json["orderId"],
    date: DateTime.parse(json["date"]) ,
    total: json["total"],
    deliveyAddress: json["deliveryAddress"]??'',
    image: json["image"]??'',
    statusText: json["statusText"]??'',
    status: OrderStatus.fromJson(json["status"]?? "held")
  );
}