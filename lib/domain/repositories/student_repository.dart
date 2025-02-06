import 'package:komando_swimming_club/domain/entities/student.dart';

abstract class StudentRepository {
  Future<List<Student>?> getStudents();
  Future<Student?> addStudent(Student student);
}