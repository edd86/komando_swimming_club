import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/data/repositories/expense_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/incomme_repository_impl.dart';
import 'package:sqflite/sqflite.dart';

class TransactionReportProvider extends ChangeNotifier {
  final Database db;

  TransactionReportProvider({required this.db});

  List<Transactions> _transactions = [];
  double _amount = 0.0;

  List<Transactions> get transactions => _transactions;
  double get amount => _amount;

  getTransactions(DateTime initDate, DateTime endDate) async {
    List<Transactions> transactionsTemp = [];
    final incommes = await IncommeRepositoryImpl(db: db).getIncommes();
    final expenses = await ExpenseRepositoryImpl(db: db).getExpenses();
    if (incommes != null && expenses != null) {
      for (var incomme in incommes) {
        if (incomme.date.isAfter(initDate.subtract(Duration(hours: 24))) &&
            incomme.date.isBefore(endDate.add(Duration(hours: 24)))) {
          transactionsTemp.add(Transactions(
            amount: incomme.amount,
            date: incomme.date,
            description: incomme.obs,
            type: 'income',
          ));
        }
      }
      for (var expense in expenses) {
        if (expense.date.isAfter(initDate.subtract(Duration(hours: 24))) &&
            expense.date.isBefore(initDate.add(Duration(hours: 24)))) {
          transactionsTemp.add(Transactions(
            amount: expense.amount,
            date: expense.date,
            description: expense.obs,
            type: 'expense',
          ));
        }
      }
      _transactions = transactionsTemp;
      _amount = transactionsTemp.fold(0.0, (prev, element) {
        if (element.type == 'income') {
          return prev + element.amount;
        } else {
          return prev - element.amount;
        }
      });
      notifyListeners();
    } else {
      _transactions = [];
    }
  }
}
