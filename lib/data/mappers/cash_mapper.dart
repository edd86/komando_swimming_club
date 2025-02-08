import 'package:komando_swimming_club/data/models/cash_model.dart';
import 'package:komando_swimming_club/domain/entities/cash.dart';

class CashMapper {
  Cash modelToCash(CashModel cashModel) {
    return Cash(
      id: cashModel.id,
      amount: cashModel.amount,
    );
  }

  CashModel cashToModel(Cash cash) {
    return CashModel(
      id: cash.id,
      amount: cash.amount,
    );
  }
} 