import 'package:komando_swimming_club/data/models/expense_model.dart';
import 'package:komando_swimming_club/domain/entities/expense.dart';

class ExpenseMapper {
  Expense modelToExpense(ExpenseModel expense) {
    return Expense(
      id: expense.id,
      date: expense.date,
      amount: expense.amount,
      obs: expense.obs,
      cashId: expense.cashId,
    );
  }

  ExpenseModel expenseToModel(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      date: expense.date,
      amount: expense.amount,
      obs: expense.obs,
      cashId: expense.cashId,
    );
  }
}
