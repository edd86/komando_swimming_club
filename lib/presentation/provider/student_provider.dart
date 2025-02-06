import 'package:flutter/material.dart';
import 'package:komando_swimming_club/data/repositories/student_repository_impl.dart';
import 'package:komando_swimming_club/domain/entities/student.dart';
import 'package:sqflite/sqflite.dart';

class StudentProvider extends ChangeNotifier {
  Database db;
  StudentProvider({required this.db}){getStudents();}

  List<Student> _students = [];

  List<Student> get students => _students;

  getStudents() async {
    _students = await StudentRepositoryImpl(db: db).getStudents() ?? [];
    notifyListeners();
  }

  searchStudente(String search) {
    _students =
        _students.where((student) => student.name.contains(search)).toList();
    notifyListeners();
  }
}
