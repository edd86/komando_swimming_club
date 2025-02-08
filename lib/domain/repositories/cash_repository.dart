import 'package:komando_swimming_club/domain/entities/cash.dart';

abstract class CashRepository {
  Future<Cash?> addCash(Cash cash);
  Future<Cash?> getCash();
  Future<int?> updateCash(Cash cash);
  Future<int?> updateCashAmount(double amount);
}
