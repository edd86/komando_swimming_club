import 'package:komando_swimming_club/data/models/proffesor_model.dart';
import 'package:komando_swimming_club/domain/entities/proffesor.dart';

class ProffessorMapper {
  Proffesor proffesorModelToProffesor(ProffesorModel proffesorModel) {
    return Proffesor(
      id: proffesorModel.id,
      name: proffesorModel.name,
      age: proffesorModel.age,
      phone: proffesorModel.phone,
      dateOfBirth: proffesorModel.dateOfBirth,
      beginDate: proffesorModel.beginDate,
      obs: proffesorModel.obs,
    );
  }

  ProffesorModel proffesorToProffesorModel(Proffesor proffesor) {
    return ProffesorModel(
      id: proffesor.id,
      name: proffesor.name,
      age: proffesor.age,
      phone: proffesor.phone,
      dateOfBirth: proffesor.dateOfBirth,
      beginDate: proffesor.beginDate,
      obs: proffesor.obs,
    );
  }
}