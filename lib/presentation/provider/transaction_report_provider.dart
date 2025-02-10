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
        transactionsTemp.add(Transactions(
          amount: incomme.amount,
          date: incomme.date,
          description: incomme.obs,
          type: 'income',
        ));
      }
      for (var expense in expenses) {
        transactionsTemp.add(Transactions(
          amount: expense.amount,
          date: expense.date,
          description: expense.obs,
          type: 'expense',
        ));
      }
      final transactionsSelected = transactionsTemp.where((trans) {
        return trans.date.isAfter(initDate.subtract(Duration(seconds: 1))) &&
            trans.date.isBefore(endDate.add(Duration(hours: 1)));
      }).toList();
      _transactions = transactionsSelected;
      _amount = transactionsSelected.fold(0.0, (prev, element) {
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
