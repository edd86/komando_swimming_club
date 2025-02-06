import 'package:komando_swimming_club/data/models/student_model.dart';
import 'package:komando_swimming_club/domain/entities/student.dart';

class StudentMapper {
  StudentModel studentToModel(Student student) {
    return StudentModel(
      id: student.id,
      name: student.name,
      age: student.age,
      phone: student.phone,
      dateOfBirth: student.dateOfBirth,
      dateOfRegister: student.dateOfRegister,
      obs: student.obs,
      ppff: student.ppff,
      profesorId: student.profesorId,
    );
  }

  Student modelToStudent(StudentModel model) {
    return Student(
      id: model.id,
      name: model.name,
      age: model.age,
      phone: model.phone,
      dateOfBirth: model.dateOfBirth,
      dateOfRegister: model.dateOfRegister,
      obs: model.obs,
      ppff: model.ppff,
      profesorId: model.profesorId,
    );
  }
}