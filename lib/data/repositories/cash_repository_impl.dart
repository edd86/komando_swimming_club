import 'package:komando_swimming_club/data/mappers/cash_mapper.dart';
import 'package:komando_swimming_club/data/models/cash_model.dart';
import 'package:komando_swimming_club/domain/entities/cash.dart';
import 'package:komando_swimming_club/domain/repositories/cash_repository.dart';
import 'package:sqflite/sqflite.dart';

class CashRepositoryImpl implements CashRepository {
  final Database db;
  CashRepositoryImpl({required this.db});
  @override
  Future<Cash?> addCash(Cash cash) async {
    try {
      final id =
          await db.insert('caja', CashMapper().cashToModel(cash).toJson());
      return CashMapper()
          .modelToCash(CashMapper().cashToModel(cash).copyWith(id: id));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Cash?> getCash() async {
    try {
      final cashFound = await db.query('caja');
      if (cashFound.isNotEmpty) {
        return CashMapper().modelToCash(CashModel.fromJson(cashFound.first));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int?> updateCash(Cash cash) async {
    try {
      final cashTemp = await db.query('caja');
      final values = CashMapper().cashToModel(cash).toJson();
      final id = await db.update('caja', values,
          where: 'id = ?', whereArgs: [cashTemp.first['id']]);
      return id;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int?> updateCashAmount(double amount) async {
    try {
      final cashTemp = await db.query('caja');
      final cash = CashModel.fromJson(cashTemp.first);
      cash.amount = cash.amount + amount;
      final cont = await updateCash(CashMapper().modelToCash(cash));
      return cont;
    } catch (e) {
      return null;
    }
  }
}
