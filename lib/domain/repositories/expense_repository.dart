import 'package:komando_swimming_club/domain/entities/expense.dart';

abstract class ExpenseRepository {
  Future<Expense?> addExpense(Expense expense);
  Future<List<Expense>?> getExpenses();
}
