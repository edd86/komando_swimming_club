import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/data/data_sources/db_helper.dart';
import 'package:komando_swimming_club/data/repositories/assitance_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/historical_register_repository_impl.dart';
import 'package:komando_swimming_club/domain/entities/assistance.dart';
import 'package:komando_swimming_club/domain/entities/historial_register.dart';
import 'package:komando_swimming_club/domain/entities/proffesor.dart';
import 'package:komando_swimming_club/domain/entities/student.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/general_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AssistantDialogWidget extends StatefulWidget {
  final Proffesor? proffesor;
  final Student? student;
  const AssistantDialogWidget({this.proffesor, this.student, super.key});

  @override
  State<AssistantDialogWidget> createState() => _AssistantDialogWidgetState();
}

class _AssistantDialogWidgetState extends State<AssistantDialogWidget> {
  String _stateSelected = 'Presente';

  final List<String> _states = ['Presente', 'Ausente', 'Licencia'];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeStyleProvider>(
        builder: (context, themeProvider, child) {
      return AlertDialog(
        title: Text(
          widget.proffesor == null
              ? widget.student!.name
              : widget.proffesor!.name,
          style: AppFonts.textCardTitleStyle(),
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          height: 22.h,
          child: Column(
            children: _states.map(
              (state) {
                return RadioListTile<String>(
                  value: state,
                  groupValue: _stateSelected,
                  tileColor: themeProvider.isDark ? Colors.black : Colors.white,
                  title: Text(
                    state,
                    style: AppFonts.textCardStyle(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _stateSelected = value!;
                    });
                  },
                );
              },
            ).toList(),
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Aceptar',
              style: AppFonts.textButtonStyle(),
            ),
            onPressed: () async {
              if (widget.proffesor != null) {
                final assitanceRepo =
                    AssitanceRepositoryImpl(db: await DbHelper().db);
                final newAssitance = Assistance(
                  dateIn: DateTime.now(),
                  state: _stateSelected.toLowerCase(),
                  proffesorId: widget.proffesor!.id!,
                );
                final response =
                    await assitanceRepo.addTeacherAssitance(newAssitance);
                if (response != null) {
                  final historialRegisterRepo =
                      HistorialRegisterRepositoryImpl(db: await DbHelper().db);
                  final newhistorical = HistorialRegister(
                      date: DateTime.now(),
                      action: 'Asistencia Profesor, ${widget.proffesor!.name}',
                      userId: userLogged!.id!,
                      profesorId: widget.proffesor!.id);
                  if (response.id != null) {
                    _assistanceAdded(themeProvider.isDark);
                    await historialRegisterRepo
                        .addHistorialRegister(newhistorical);
                  } else {
                    _assistanceNotAdded(themeProvider.isDark);
                  }
                } else {
                  _assistanceError(themeProvider.isDark);
                }
              }
              if (widget.student != null) {
                final assitanceRepo =
                    AssitanceRepositoryImpl(db: await DbHelper().db);
                final newAssitance = Assistance(
                  dateIn: DateTime.now(),
                  state: _stateSelected.toLowerCase(),
                  studentId: widget.student!.id!,
                );
                final response =
                    await assitanceRepo.addStudentAssitance(newAssitance);
                if (response != null) {
                  final historialRegisterRepo =
                      HistorialRegisterRepositoryImpl(db: await DbHelper().db);
                  final newhistorical = HistorialRegister(
                      date: DateTime.now(),
                      action: 'Asistencia Estudiante, ${widget.student!.name}',
                      userId: userLogged!.id!,
                      studentId: widget.student!.id);
                  if (response.id != null) {
                    _assistanceAdded(themeProvider.isDark);
                    await historialRegisterRepo
                        .addHistorialRegister(newhistorical);
                  } else {
                    _assistanceNotAdded(themeProvider.isDark);
                  }
                } else {
                  _assistanceError(themeProvider.isDark);
                }
              }
            },
          ),
          TextButton(
            child: Text(
              'Cancelar',
              style: AppFonts.textButtonStyle(),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    });
  }

  _assistanceAdded(bool isDark) {
    GeneralWidgets.showSnackBar(context, 'Asistencia agregada', isDark);
    Navigator.pop(context);
  }

  _assistanceNotAdded(bool isDark) {
    GeneralWidgets.showSnackBar(
        context, 'No se pudo agregar asistencia', isDark);
  }

  void _assistanceError(bool isDark) {
    GeneralWidgets.showSnackBar(context, 'Error al agregar asistencia', isDark);
  }
}
