import 'package:komando_swimming_club/domain/entities/student.dart';

abstract class StudentRepository {
  Future<List<Student>?> getStudents();
  Future<Student?> addStudent(Student student);
  Future<int?> deleteStudent(Student student);
  Future<int?> updateStudent(Student student);
}
