enum WalletTransactionType {
  payment,
  topUp,
  refund;

  bool get isCredit => this != payment;
}
