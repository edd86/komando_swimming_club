class CashModel {
  int? id;
  double amount;

  CashModel({
    this.id,
    required this.amount,
  });

  factory CashModel.fromJson(Map<String, dynamic> json) {
    return CashModel(
      id: json['id'],
      amount: json['monto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'monto': amount,
    };
  }
}
