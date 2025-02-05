import 'package:komando_swimming_club/data/mappers/proffessor_mapper.dart';
import 'package:komando_swimming_club/data/models/proffesor_model.dart';
import 'package:komando_swimming_club/domain/entities/proffesor.dart';
import 'package:komando_swimming_club/domain/repositories/proffesor_repository.dart';
import 'package:sqflite/sqflite.dart';

class ProffessorRepositoryImpl extends ProffesorRepository {
  final Database db;
  ProffessorRepositoryImpl({required this.db});
  @override
  Future<Proffesor?> addProffesor(Proffesor proffesor) async {
    try {
      int id = await db.insert('profesores',
          ProffessorMapper().proffesorToProffesorModel(proffesor).toJson());
      final newProffesor = ProffessorMapper()
          .proffesorToProffesorModel(proffesor)
          .copyWith(id: id);
      return ProffessorMapper().proffesorModelToProffesor(newProffesor);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Proffesor>?> getProffessors() async {
    try {
      final proffesorsRes = await db.query('profesores');
      return proffesorsRes
          .map((proffesor) => ProffessorMapper()
              .proffesorModelToProffesor(ProffesorModel.fromJson(proffesor)))
          .toList();
    } catch (e) {
      return null;
    }
  }
}
