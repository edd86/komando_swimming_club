class Expense {
  int? id;
  DateTime date;
  double amount;
  String obs;
  int cashId;

  Expense({
    this.id,
    required this.date,
    required this.amount,
    required this.obs,
    required this.cashId,
  });
}