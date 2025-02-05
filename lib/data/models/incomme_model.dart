class IncommeModel {
  int? id;
  String date;
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
