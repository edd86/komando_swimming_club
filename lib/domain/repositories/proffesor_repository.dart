import 'package:komando_swimming_club/domain/entities/proffesor.dart';

abstract class ProffesorRepository {
  Future<Proffesor?> addProffesor(Proffesor proffesor);

  Future<List<Proffesor>?> getProffessors();
}
