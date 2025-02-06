import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/data/data_sources/db_helper.dart';
import 'package:komando_swimming_club/data/repositories/assitance_repository_impl.dart';
import 'package:komando_swimming_club/domain/entities/assistance.dart';
import 'package:komando_swimming_club/domain/entities/proffesor.dart';
import 'package:komando_swimming_club/presentation/widgets/general_widgets.dart';
import 'package:sizer/sizer.dart';

class AssistantDialogWidget extends StatefulWidget {
  final Proffesor? proffesor;
  const AssistantDialogWidget({this.proffesor, super.key});

  @override
  State<AssistantDialogWidget> createState() => _AssistantDialogWidgetState();
}

class _AssistantDialogWidgetState extends State<AssistantDialogWidget> {
  String _stateSelected = 'Presente';

  final List<String> _states = ['Presente', 'Ausente', 'Licencia'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.proffesor!.name,
        style: AppFonts.textCardTitleStyle(),
      ),
      content: SizedBox(
        height: 15.h,
        child: Column(
          children: _states.map((state) {
            return RadioListTile<String>(
              title: Text(
                state,
                style: AppFonts.textCardStyle(),
              ),
              value: state,
              groupValue: _stateSelected,
              onChanged: (value) {
                setState(() {
                  _stateSelected = value!;
                });
              },
            );
          }).toList(),
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
                response.id != null
                    ? _assistanceAdded()
                    : _assistanceNotAdded();
              } else {
                _assistanceError();
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
  }

  _assistanceAdded() {
    GeneralWidgets.showSnackBar(context, 'Asistencia agregada');
    Navigator.pop(context);
  }

  _assistanceNotAdded() {
    GeneralWidgets.showSnackBar(context, 'No se pudo agregar asistencia');
  }

  void _assistanceError() {
    GeneralWidgets.showSnackBar(context, 'Error al agregar asistencia');
  }
}
