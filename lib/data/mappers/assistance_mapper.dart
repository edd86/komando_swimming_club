import 'package:komando_swimming_club/data/models/assitance_model.dart';
import 'package:komando_swimming_club/domain/entities/assistance.dart';

class AssistanceMapper {
  AssitanceModel assitanceToModel(Assistance assistance) {
    return AssitanceModel(
      id: assistance.id,
      dateIn: assistance.dateIn,
      dateOut: assistance.dateOut,
      obs: assistance.obs,
      state: assistance.state,
      studentId: assistance.studentId,
      proffesorId: assistance.proffesorId,
    );
  }

  Assistance modelToAssitance(AssitanceModel model) {
    return Assistance(
      id: model.id,
      dateIn: model.dateIn,
      dateOut: model.dateOut,
      obs: model.obs,
      state: model.state!,
      studentId: model.studentId,
      proffesorId: model.proffesorId,
    );
  }
}
