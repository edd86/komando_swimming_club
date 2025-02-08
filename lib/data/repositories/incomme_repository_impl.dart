import 'package:komando_swimming_club/data/mappers/incomme_mapper.dart';
import 'package:komando_swimming_club/data/models/incomme_model.dart';
import 'package:komando_swimming_club/domain/entities/incomme.dart';
import 'package:komando_swimming_club/domain/repositories/incomme_repository.dart';
import 'package:sqflite/sqflite.dart';

class IncommeRepositoryImpl implements IncommeRepository {
  final Database db;
  IncommeRepositoryImpl({required this.db});

  @override
  Future<Incomme?> addIncomme(Incomme incomme) async {
    try {
      final id = await db.insert(
          'ingresos', IncommeMapper().incommeToModel(incomme).toJson());
      return IncommeMapper().modelToIncomme(
        IncommeMapper().incommeToModel(incomme).copyWith(id: id),
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<List<Incomme>?> getIncommes() async {
    try {
      final incommes = await db.query('ingresos');
      if (incommes.isNotEmpty) {
        return incommes
            .map((incomme) =>
                IncommeMapper().modelToIncomme(IncommeModel.fromJson(incomme)))
            .toList();
      }
      return [];
    } catch (e) {
      return null;
    }
  }
}
