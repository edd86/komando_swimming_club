import 'dart:async';

import 'package:komando_swimming_club/data/data_sources/sqlite_code.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._();
  static Database? _db;

  DbHelper._();

  factory DbHelper() {
    return _instance;
  }

  Future<Database> get db async {
    _db ??= await _initDb('swimming_database.db');
    return _db!;
  }

  Future<Database> _initDb(String dbName) async {
    final path = await getDatabasesPath();
    final dbPath = '$path/$dbName';
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createDb,
      onUpgrade: _upgradeDatabase,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(sqlUsers);
    await db.execute(sqlProfesores);
    await db.execute(sqlCaja);
    await db.execute(sqlAlumnos);
    await db.execute(sqlIngresos);
    await db.execute(sqlEgresos);
    await db.execute(sqlAsistencias);
    await db.execute(sqlRegistros);
    await db.execute(sqlRegistroLogs);
  }
  
  Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async{
    
  }
}
