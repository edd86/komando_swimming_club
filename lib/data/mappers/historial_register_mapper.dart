import 'package:komando_swimming_club/data/models/historial_register_model.dart';
import 'package:komando_swimming_club/domain/entities/historial_register.dart';

class HistorialRegisterMapper {
  HistorialRegister modelToHistorialRegister(
      HistorialRegisterModel historialRegisterModel) {
    return HistorialRegister(
      id: historialRegisterModel.id,
      date: historialRegisterModel.date,
      action: historialRegisterModel.action,
      userId: historialRegisterModel.userId,
      profesorId: historialRegisterModel.profesorId,
      studentId: historialRegisterModel.studentId,
      ingressId: historialRegisterModel.ingressId,
      egressId: historialRegisterModel.egressId,
    );
  }

  HistorialRegisterModel historialRegisterToModel(
      HistorialRegister historialRegister) {
    return HistorialRegisterModel(
      id: historialRegister.id,
      date: historialRegister.date,
      action: historialRegister.action,
      userId: historialRegister.userId,
      profesorId: historialRegister.profesorId,
      studentId: historialRegister.studentId,
      ingressId: historialRegister.ingressId,
      egressId: historialRegister.egressId,
    );
  }
}
