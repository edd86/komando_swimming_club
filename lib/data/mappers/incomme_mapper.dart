import 'package:komando_swimming_club/data/models/incomme_model.dart';
import 'package:komando_swimming_club/domain/entities/incomme.dart';

class IncommeMapper {
  Incomme modelToIncomme(IncommeModel incommeModel) {
    return Incomme(
      id: incommeModel.id,
      date: incommeModel.date,
      amount: incommeModel.amount,
      obs: incommeModel.obs,
      cajaId: incommeModel.cashId,
    );
  }

  IncommeModel incommeToModel(Incomme incomme) {
    return IncommeModel(
      id: incomme.id,
      date: incomme.date,
      amount: incomme.amount,
      obs: incomme.obs,
      cashId: incomme.cajaId,
    );
  }
}
