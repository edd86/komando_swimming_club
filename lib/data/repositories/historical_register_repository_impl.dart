import 'package:komando_swimming_club/data/mappers/historial_register_mapper.dart';
import 'package:komando_swimming_club/domain/entities/historial_register.dart';
import 'package:komando_swimming_club/domain/repositories/historical_register_repository.dart';
import 'package:sqflite/sqflite.dart';

class HistorialRegisterRepositoryImpl implements HistorialRegisterRepository {
  final Database db;

  HistorialRegisterRepositoryImpl({required this.db});

  @override
  Future<HistorialRegister?> addHistorialRegister(
      HistorialRegister historialRegister) async {
    try {
      final id = await db.insert(
          'registros',
          HistorialRegisterMapper()
              .historialRegisterToModel(historialRegister)
              .toJson());
      return HistorialRegisterMapper().modelToHistorialRegister(
          HistorialRegisterMapper()
              .historialRegisterToModel(historialRegister)
              .copyWith(id: id));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<HistorialRegister>?> getHistorialRegisters() {
    // TODO: implement getHistorialRegisters
    throw UnimplementedError();
  }
}
