import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/presentation/provider/student_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/student_card_widget.dart';
import 'package:provider/provider.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});
  final int delay = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 45,
          child: TextField(
            decoration: InputDecoration(
              label: Row(
                children: [
                  Icon(Icons.search),
                  Text(
                    'Buscar estudiante',
                    style: AppFonts.textFieldStyle(),
                  ),
                ],
              ),
            ),
            onChanged: (value) {
              final notifier =
                  Provider.of<StudentProvider>(context, listen: false);
              if (value.isEmpty) {
                notifier.getStudents();
              } else {
                notifier.searchStudente(value);
              }
            },
          ),
        ),
        Expanded(
          child: Consumer<StudentProvider>(
              builder: (context, studentProvider, child) {
            final students = studentProvider.students;
            if (students.isEmpty) {
              return Center(
                child: Text(
                  'No hay estudiantes registrados',
                  style: AppFonts.textCardStyle(),
                ),
              );
            }
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return FadeIn(
                  delay: Duration(milliseconds: delay * (index + 1)),
                  child: StudentCardWidget(student: students[index]),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
