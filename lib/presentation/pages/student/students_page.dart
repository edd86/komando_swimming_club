import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/presentation/provider/student_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/student_card_widget.dart';
import 'package:provider/provider.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
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
          return StudentCardWidget(student: students[index]);
        },
      );
    });
  }
}
