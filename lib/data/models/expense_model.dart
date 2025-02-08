class ExpenseModel {
  int? id;
  DateTime date;
  double amount;
  String obs;
  int cashId;

  ExpenseModel({
    this.id,
    required this.date,
    required this.amount,
    required this.obs,
    required this.cashId,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      date: DateTime.parse(json['fecha']),
      amount: json['monto'],
      obs: json['obs'],
      cashId: json['cajaId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': date.toIso8601String(),
      'monto': amount,
      'obs': obs,
      'cajaId': cashId,
    };
  }

  ExpenseModel copyWith({
    int? id,
    DateTime? date,
    double? amount,
    String? obs,
    int? cashId,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      obs: obs ?? this.obs,
      cashId: cashId ?? this.cashId,
    );
  }
}
