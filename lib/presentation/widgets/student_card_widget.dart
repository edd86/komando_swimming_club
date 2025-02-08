import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/utils/conversors.dart';
import 'package:komando_swimming_club/data/data_sources/db_helper.dart';
import 'package:komando_swimming_club/data/repositories/assitance_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/student_repository_impl.dart';
import 'package:komando_swimming_club/domain/entities/assistance.dart';
import 'package:komando_swimming_club/domain/entities/student.dart';
import 'package:komando_swimming_club/presentation/provider/student_provider.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/assistant_dialog_widget.dart';
import 'package:komando_swimming_club/presentation/widgets/general_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class StudentCardWidget extends StatelessWidget {
  final Student student;
  const StudentCardWidget({required this.student, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeStyleProvider>(
      builder: (context, themeProvider, child) {
        return Card(
          color: themeProvider.isDark ? Colors.green[900] : Colors.green[200],
          child: Stack(
            children: [
              SizedBox(
                height: 24.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      student.name,
                      style: AppFonts.textCardTitleStyle(),
                    ),
                    Text(
                      student.ppff,
                      style: AppFonts.textCardStyle(),
                    ),
                    Text(
                      student.phone,
                      style: AppFonts.textCardStyle(),
                    ),
                    Text(
                      student.obs,
                      style: AppFonts.textCardStyle(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            child: Row(
                          children: [
                            Icon(FontAwesomeIcons.cakeCandles),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              student.age.toString(),
                              style: AppFonts.textCardStyle(),
                            ),
                          ],
                        )),
                        SizedBox(
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.cakeCandles),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                Conversors.dateToString(student.dateOfBirth),
                                style: AppFonts.textCardStyle(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Icon(Icons.start),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                Conversors.dateToString(student.dateOfRegister),
                                style: AppFonts.textCardStyle(),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              MenuAnchor(
                menuChildren: [
                  MenuItemButton(
                    child: Text(
                      'Asistencia',
                      style: AppFonts.textMenuAnchorStyle(),
                    ),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (_) =>
                            AssistantDialogWidget(student: student)),
                  ),
                  MenuItemButton(
                    child: Text(
                      'Salida',
                      style: AppFonts.textMenuAnchorStyle(),
                    ),
                    onPressed: () async {
                      final assitanceRepo =
                          AssitanceRepositoryImpl(db: await DbHelper().db);
                      final assistanceOut = Assistance(
                        dateOut: DateTime.now(),
                        studentId: student.id!,
                      );
                      final id = await assitanceRepo
                          .editStudentAssitanceOut(assistanceOut);
                      if (id != null && id > 0) {
                        GeneralWidgets.showSnackBar(
                            context,
                            'Asistencia de salida registrada',
                            themeProvider.isDark);
                      } else {
                        GeneralWidgets.showSnackBar(
                            context,
                            'No tiene asistencia de entrada',
                            themeProvider.isDark);
                      }
                    },
                  ),
                  MenuItemButton(
                    child: Text(
                      'Editar',
                      style: AppFonts.textMenuAnchorStyle(),
                    ),
                    onPressed: () {},
                  ),
                  MenuItemButton(
                    child: Text(
                      'Eliminar',
                      style: AppFonts.textMenuAnchorStyle(),
                    ),
                    onPressed: () async {
                      final studentRepo =
                          StudentRepositoryImpl(db: await DbHelper().db);
                      final count = await studentRepo.deleteStudent(student);
                      if (count > 0) {
                        final notifier = Provider.of<StudentProvider>(context,
                            listen: false);
                        notifier.getStudents();
                        GeneralWidgets.showSnackBar(context,
                            'Estudiante eliminado', themeProvider.isDark);
                      } else {
                        GeneralWidgets.showSnackBar(
                            context,
                            'No se pudo eliminar el estudiante',
                            themeProvider.isDark);
                      }
                    },
                  ),
                ],
                builder: (context, controller, child) {
                  return IconButton(
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    icon: Icon(Icons.more_vert),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
