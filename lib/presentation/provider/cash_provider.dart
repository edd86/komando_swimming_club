import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/data/repositories/cash_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/expense_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/incomme_repository_impl.dart';
import 'package:sqflite/sqflite.dart';

class CashProvider extends ChangeNotifier {
  final Database db;

  CashProvider({required this.db}) {
    getAmount();
    getTransactions();
  }

  double _amount = 0.0;
  List<Transactions> _transactions = [];

  double get amount => _amount;
  List<Transactions> get transactions => _transactions;

  getAmount() async {
    final cash = await CashRepositoryImpl(db: db).getCash();
    if (cash != null) {
      _amount = cash.amount;
      notifyListeners();
    }
  }

  getTransactions() async {
    List<Transactions> transactionsTemp = [];
    final incommes = await IncommeRepositoryImpl(db: db).getIncommes();
    final expenses = await ExpenseRepositoryImpl(db: db).getExpenses();
    if (incommes != null && expenses != null) {
      for (var incomme in incommes) {
        transactionsTemp.add(Transactions(
          amount: incomme.amount,
          date: incomme.date,
          description: incomme.obs,
        ));
      }
      for (var expense in expenses) {
        transactionsTemp.add(Transactions(
          amount: expense.amount,
          date: expense.date,
          description: expense.obs,
        ));
      }
      transactionsTemp.sort((a, b) => b.date.compareTo(a.date));
      _transactions = transactionsTemp;
      notifyListeners();
    } else {
      _transactions = [];
    }
  }
}
