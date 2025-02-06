import 'package:komando_swimming_club/data/mappers/assistance_mapper.dart';
import 'package:komando_swimming_club/data/models/assitance_model.dart';
import 'package:komando_swimming_club/domain/entities/assistance.dart';
import 'package:komando_swimming_club/domain/repositories/assistance_repository.dart';
import 'package:sqflite/sqflite.dart';

class AssitanceRepositoryImpl implements AssistanceRepository {
  final Database db;
  AssitanceRepositoryImpl({required this.db});
  @override
  Future<Assistance?> addStudentAssitance(Assistance assistance) async {
    try {
      final id = await db.insert('asistencias',
          AssistanceMapper().assitanceToModel(assistance).toJson());
      return AssistanceMapper().modelToAssitance(
          AssistanceMapper().assitanceToModel(assistance).copyWith(id: id));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Assistance?> addTeacherAssitance(Assistance assistance) async {
    try {
      final id = await db.insert('asistencias',
          AssistanceMapper().assitanceToModel(assistance).toJson());
      return AssistanceMapper().modelToAssitance(
          AssistanceMapper().assitanceToModel(assistance).copyWith(id: id));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int?> editTeacherAssitanceOut(Assistance assistance) async {
    try {
      final assistances = await db.query('asistencias',
          where:
              'profesorId = ? AND fecha_salida IS NULL AND estado = "presente"',
          whereArgs: [assistance.proffesorId]);
      if (assistances.isNotEmpty) {
        final assistanceFound =
            AssitanceModel.fromJson(assistances.last).copyWith(
          id: assistance.id,
          dateIn: assistance.dateIn,
          dateOut: assistance.dateOut,
          state: assistance.state,
          obs: assistance.obs,
          studentId: assistance.studentId,
          proffesorId: assistance.proffesorId,
        );
        return await db.update(
          'asistencias',
          assistanceFound.toJson(),
          where: 'id = ?',
          whereArgs: [assistanceFound.id],
        );
      }
      return 0;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int?> editStudentAssitanceOut(Assistance assistance) async {
    try {
      final assistances = await db.query('asistencias',
          where:
              'alumnoId = ? AND fecha_salida IS NULL AND estado = "presente"',
          whereArgs: [assistance.studentId]);
      if (assistances.isNotEmpty) {
        final assistanceFound =
            AssitanceModel.fromJson(assistances.last).copyWith(
          id: assistance.id,
          dateIn: assistance.dateIn,
          dateOut: assistance.dateOut,
          state: assistance.state,
          obs: assistance.obs,
          studentId: assistance.studentId,
          proffesorId: assistance.proffesorId,
        );
        return await db.update(
          'asistencias',
          assistanceFound.toJson(),
          where: 'id = ?',
          whereArgs: [assistanceFound.id],
        );
      }
      return 0;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
