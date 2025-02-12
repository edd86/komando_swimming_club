import 'package:komando_swimming_club/data/repositories/proffessor_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/student_repository_impl.dart';
import 'package:sqflite/sqflite.dart';

class Utils {
  int calculateAge(DateTime dateOfBirth) {
    final DateTime now = DateTime.now();
    final int bMonth = dateOfBirth.month;
    final int bDay = dateOfBirth.day;
    if (now.month < bMonth) {
      return now.year - dateOfBirth.year - 1;
    }
    if (now.month == bMonth && now.day < bDay) {
      return now.year - dateOfBirth.year - 1;
    } else {
      return now.year - dateOfBirth.year;
    }
  }

  void updateAges(Database db) async {
    final proffesorRepo = ProffessorRepositoryImpl(db: db);
    final studentRepo = StudentRepositoryImpl(db: db);
    final proffesors = await proffesorRepo.getProffessors();
    final students = await StudentRepositoryImpl(db: db).getStudents();
    for (var proffesor in proffesors!) {
      proffesor.age = calculateAge(proffesor.dateOfBirth);
      proffesorRepo.updateProffesor(proffesor);
    }
    for (var student in students!) {
      student.age = calculateAge(student.dateOfBirth);
      studentRepo.updateStudent(student);
    }
  }
}
