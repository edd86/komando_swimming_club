import 'package:flutter/material.dart';
import 'package:komando_swimming_club/data/repositories/proffessor_repository_impl.dart';
import 'package:komando_swimming_club/domain/entities/proffesor.dart';
import 'package:sqflite/sqflite.dart';

class ProffesorProvider extends ChangeNotifier {
  final Database db;
  ProffesorProvider({required this.db}) {
    getProffesors();
  }

  List<Proffesor> _proffesors = [];

  List<Proffesor> get proffesors => _proffesors;

  void getProffesors() async {
    final proffesors = await ProffessorRepositoryImpl(db: db).getProffessors();
    if (proffesors != null) {
      _proffesors = proffesors;
      notifyListeners();
    }
  }

  void searchProffesor(String search) {
    _proffesors = _proffesors
        .where((proffessor) => proffessor.name.contains(search))
        .toList();
    notifyListeners();
  }
}
