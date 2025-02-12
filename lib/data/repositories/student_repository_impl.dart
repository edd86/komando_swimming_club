import 'package:komando_swimming_club/data/mappers/student_mapper.dart';
import 'package:komando_swimming_club/data/models/student_model.dart';
import 'package:komando_swimming_club/domain/entities/student.dart';
import 'package:komando_swimming_club/domain/repositories/student_repository.dart';
import 'package:sqflite/sqflite.dart';

class StudentRepositoryImpl implements StudentRepository {
  final Database db;
  StudentRepositoryImpl({required this.db});

  @override
  Future<List<Student>?> getStudents() async {
    try {
      final students = await db.query('alumnos');
      return students.isNotEmpty
          ? students
              .map((student) => StudentMapper()
                  .modelToStudent(StudentModel.fromJson(student)))
              .toList()
          : [];
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Student?> addStudent(Student student) async {
    try {
      final id = await db.insert(
          'alumnos', StudentMapper().studentToModel(student).toJson());
      return StudentMapper().modelToStudent(
          StudentMapper().studentToModel(student).copyWith(id: id));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int> deleteStudent(Student student) async {
    try {
      await db.delete('asistencias',
          where: 'alumnoId = ?', whereArgs: [student.id]);
      await db
          .delete('registros', where: 'alumnoId = ?', whereArgs: [student.id]);
      return await db
          .delete('alumnos', where: 'id = ?', whereArgs: [student.id]);
    } catch (e) {
      return 0;
    }
  }

  @override
  Future<int?> updateStudent(Student student) async {
    try {
      return await db.update(
          'alumnos', StudentMapper().studentToModel(student).toJson(),
          where: 'id = ?', whereArgs: [student.id]);
    } catch (e) {
      return 0;
    }
  }
}
