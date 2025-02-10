import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/data/repositories/historical_register_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/user_repository_impl.dart';
import 'package:sqflite/sqflite.dart';

class RegisterReportsProvider extends ChangeNotifier {
  final Database db;
  RegisterReportsProvider({required this.db}) {
    getHistorialRegisters();
  }

  List<HistorialRegisterTile> _historialRegisters = [];

  List<HistorialRegisterTile> get historialRegisters => _historialRegisters;

  getHistorialRegisters() async {
    final historialRegisters =
        await HistorialRegisterRepositoryImpl(db: db).getHistorialRegisters();
    if (historialRegisters != null) {
      for (var historialRegister in historialRegisters) {
        final usersResgistered = await UserRepositoryImpl(db: db)
            .getUserById(historialRegister.userId);
        if (usersResgistered != null) {
          _historialRegisters.add(
            HistorialRegisterTile(
              name: usersResgistered.userName,
              date: historialRegister.date,
              action: historialRegister.action,
              userId: historialRegister.userId,
            ),
          );
        } else {
          _historialRegisters.add(
            HistorialRegisterTile(
              name: 'Usuario no registrado',
              date: historialRegister.date,
              action: historialRegister.action,
              userId: historialRegister.userId,
            ),
          );
        }
      }
      notifyListeners();
    } else {
      _historialRegisters = [];
    }
  }
}
