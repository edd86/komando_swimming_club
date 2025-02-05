class ExpenseModel {
  int? id;
  String date;
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
      date: json['date'],
      amount: json['amount'],
      obs: json['obs'],
      cashId: json['cajaId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'obs': obs,
      'cajaId': cashId,
    };
  }
}