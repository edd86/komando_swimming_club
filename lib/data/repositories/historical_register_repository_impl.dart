import 'package:komando_swimming_club/data/mappers/historial_register_mapper.dart';
import 'package:komando_swimming_club/data/models/historial_register_model.dart';
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
  Future<List<HistorialRegister>?> getHistorialRegisters() async {
    try {
      final historialRegisters = await db.query('registros');
      if (historialRegisters.isNotEmpty) {
        return historialRegisters
            .map((historialRegister) => HistorialRegisterMapper()
                .modelToHistorialRegister(
                    HistorialRegisterModel.fromJson(historialRegister)))
            .toList();
      }
      return [];
    } catch (e) {
      return null;
    }
  }
}
