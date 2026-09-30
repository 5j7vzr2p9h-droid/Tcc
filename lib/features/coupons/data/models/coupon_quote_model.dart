import '../../domain/entities/coupon_quote_entity.dart';

final class const CouponQuoteModel({
  required super.code,
  required super.subtotal,
  required super.discount
}) extends CouponQuoteEntity{

  factory CouponQuoteModel.fromJson(dynamic json)
  => CouponQuoteModel(
    code: json["code"]??'',
    subtotal: ((json["subtotal"] as num?) ?? 0).toDouble(),
    discount: ((json["discount"] as num?) ?? 0).toDouble()
  );
}
