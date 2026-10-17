import '../../domain/entities/wallet_transaction_entity.dart';

final class const WalletTransactionModel({
  required super.type,
  required super.amount,
  required super.description,
  required super.date,
  required super.isSuccessful
}) extends WalletTransactionEntity {

  factory WalletTransactionModel.fromJson(dynamic json)
  => WalletTransactionModel(
    type: json["type"],
    amount: json["amount"],
    description: json["description"],
    date: json["date"],
    isSuccessful: json["isSuccessful"]
  );
}