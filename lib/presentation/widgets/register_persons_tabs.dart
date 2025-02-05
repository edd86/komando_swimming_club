import 'package:flutter/material.dart';
import 'package:komando_swimming_club/presentation/pages/register/register_proffesor_page.dart';
import 'package:komando_swimming_club/presentation/pages/register/register_student_page.dart';

class RegisterPersonsTabs extends StatelessWidget {
  const RegisterPersonsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Registro Personas'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Profesor'),
              Tab(text: 'Estudiante'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RegisterProffesorPage(),
            RegisterStudentPage(),
          ],
        ),
      ),
    );
  }
}
