
import 'package:komando_swimming_club/domain/entities/incomme.dart';

abstract class IncommeRepository {
  Future<Incomme?> addIncomme(Incomme incomme);
  Future<List<Incomme>?> getIncommes();
}

