import 'package:komando_swimming_club/data/mappers/expense_mapper.dart';
import 'package:komando_swimming_club/data/models/expense_model.dart';
import 'package:komando_swimming_club/domain/entities/expense.dart';
import 'package:komando_swimming_club/domain/repositories/expense_repository.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final Database db;
  ExpenseRepositoryImpl({required this.db});

  @override
  Future<Expense?> addExpense(Expense expense) async {
    try {
      final id = await db.insert(
          'egresos', ExpenseMapper().expenseToModel(expense).toJson());
      return ExpenseMapper().modelToExpense(
        ExpenseMapper().expenseToModel(expense).copyWith(id: id),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Expense>?> getExpenses() async {
    try {
      final expenses = await db.query('egresos');
      if (expenses.isNotEmpty) {
        return expenses
            .map((expense) =>
                ExpenseMapper().modelToExpense(ExpenseModel.fromJson(expense)))
            .toList();
      }
      return [];
    } catch (e) {
      return null;
    }
  }
}
