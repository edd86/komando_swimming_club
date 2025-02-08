import 'package:komando_swimming_club/domain/entities/historial_register.dart';

abstract class HistorialRegisterRepository {
  Future<HistorialRegister?> addHistorialRegister(HistorialRegister historialRegister);
  Future<List<HistorialRegister>?> getHistorialRegisters();
}
