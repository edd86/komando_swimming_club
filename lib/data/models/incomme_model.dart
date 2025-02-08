class IncommeModel {
  int? id;
  DateTime date;
  double amount;
  String obs;
  int cashId;

  IncommeModel({
    this.id,
    required this.date,
    required this.amount,
    required this.obs,
    required this.cashId,
  });

  factory IncommeModel.fromJson(Map<String, dynamic> json) {
    return IncommeModel(
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

  IncommeModel copyWith({
    int? id,
    DateTime? date,
    double? amount,
    String? obs,
    int? cashId,
  }) {
    return IncommeModel(
      id: id ?? this.id,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      obs: obs ?? this.obs,
      cashId: cashId ?? this.cashId,
    );
  }
}
