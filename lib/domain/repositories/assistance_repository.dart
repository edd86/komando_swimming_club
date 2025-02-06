import 'package:komando_swimming_club/domain/entities/assistance.dart';

abstract class AssistanceRepository {
  Future<Assistance?> addTeacherAssitance(Assistance assistance);
  Future<Assistance?> addStudentAssitance(Assistance assistance);
  Future<int?> editTeacherAssitanceOut(Assistance assistance);
  Future<int?> editStudentAssitanceOut(Assistance assistance);
}