import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/core/utils/conversors.dart';
import 'package:komando_swimming_club/core/utils/utils.dart';
import 'package:komando_swimming_club/data/data_sources/db_helper.dart';
import 'package:komando_swimming_club/data/repositories/historical_register_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/student_repository_impl.dart';
import 'package:komando_swimming_club/domain/entities/historial_register.dart';
import 'package:komando_swimming_club/domain/entities/proffesor.dart';
import 'package:komando_swimming_club/domain/entities/student.dart';
import 'package:komando_swimming_club/presentation/provider/proffesor_provider.dart';
import 'package:komando_swimming_club/presentation/provider/register_reports_provider.dart';
import 'package:komando_swimming_club/presentation/provider/student_provider.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/general_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterStudentPage extends StatefulWidget {
  const RegisterStudentPage({super.key});

  @override
  State<RegisterStudentPage> createState() => _RegisterStudentPageState();
}

class _RegisterStudentPageState extends State<RegisterStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _obsController = TextEditingController();
  final _ppffController = TextEditingController();
  DateTime _dateOfBirth = DateTime.now();
  DateTime _dateOfRegister = DateTime.now();
  Proffesor? _selectedProffesor;
  final int _delay = 150;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 10.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FadeInRight(
              delay: Duration(milliseconds: _delay * 1),
              child: TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                style: AppFonts.textFieldStyle(),
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(FontAwesomeIcons.child),
                      Text(
                        'Nombre Completo',
                        style: AppFonts.textFieldStyle(),
                      ),
                    ],
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un nombre completo';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            FadeInRight(
              delay: Duration(milliseconds: _delay * 2),
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: AppFonts.textFieldStyle(),
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(FontAwesomeIcons.mobile),
                      Text(
                        'Teléfono',
                        style: AppFonts.textFieldStyle(),
                      ),
                    ],
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un número de teléfono';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            FadeInRight(
              delay: Duration(milliseconds: _delay * 3),
              child: TextFormField(
                controller: _ppffController,
                textCapitalization: TextCapitalization.words,
                style: AppFonts.textFieldStyle(),
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(FontAwesomeIcons.person),
                      Text(
                        'Padre/madre de familia',
                        style: AppFonts.textFieldStyle(),
                      ),
                    ],
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un nombre';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            FadeInRight(
              delay: Duration(milliseconds: _delay * 4),
              child: TextFormField(
                controller: _obsController,
                textCapitalization: TextCapitalization.sentences,
                style: AppFonts.textFieldStyle(),
                maxLines: 3,
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(FontAwesomeIcons.info),
                      Text(
                        'Observaciones',
                        style: AppFonts.textFieldStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            FadeInRight(
              delay: Duration(milliseconds: _delay * 5),
              child: Consumer<ProffesorProvider>(
                builder: (context, proffesorProvider, child) {
                  final proffesors = proffesorProvider.proffesors;
                  return DropdownButtonFormField<Proffesor>(
                    value: _selectedProffesor,
                    hint: Text(
                      'Seleccione un profesor',
                      style: AppFonts.textFieldStyle(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedProffesor = value;
                      });
                    },
                    items: proffesors
                        .map<DropdownMenuItem<Proffesor>>((proffesor) {
                      return DropdownMenuItem<Proffesor>(
                        value: proffesor,
                        child: Text(
                          proffesor.name,
                          style: AppFonts.textFieldStyle(),
                        ),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor, seleccione un profesor';
                      }
                      return null;
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            FadeInRight(
              delay: Duration(milliseconds: _delay * 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 10.h,
                    child: Column(
                      children: [
                        Icon(FontAwesomeIcons.cakeCandles),
                        TextButton(
                          child: Text(
                            Conversors.dateToString(_dateOfBirth),
                            style: AppFonts.textButtonStyle(),
                          ),
                          onPressed: () => _showBirthDatePicker(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                    child: Column(
                      children: [
                        Icon(FontAwesomeIcons.calendarDay),
                        TextButton(
                          child: Text(
                            Conversors.dateToString(_dateOfRegister),
                            style: AppFonts.textButtonStyle(),
                          ),
                          onPressed: () => _showRegistrationDatePicker(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            FadeIn(
              delay: Duration(milliseconds: _delay * 7),
              child: Consumer<ThemeStyleProvider>(
                builder: (context, themeProvider, child) => ElevatedButton.icon(
                  label: Text('Registrar Estudiante'),
                  icon: Icon(
                    Icons.save,
                    color: themeProvider.isDark ? Colors.black : Colors.white,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final studentRepo =
                          StudentRepositoryImpl(db: await DbHelper().db);
                      final student = await studentRepo.addStudent(Student(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        dateOfBirth: _dateOfBirth,
                        dateOfRegister: _dateOfRegister,
                        age: Utils().calculateAge(_dateOfBirth),
                        obs: _obsController.text,
                        ppff: _ppffController.text,
                        profesorId: _selectedProffesor!.id!,
                      ));
                      if (student != null && student.id != null) {
                        _studentAdded(themeProvider.isDark);
                        final historicalRegisterRepo =
                            HistorialRegisterRepositoryImpl(
                                db: await DbHelper().db);
                        await historicalRegisterRepo.addHistorialRegister(
                            HistorialRegister(
                                date: DateTime.now(),
                                action: 'Registro Estudiante, ${student.name}',
                                userId: userLogged!.id!,
                                studentId: student.id));
                      } else {
                        student == null
                            ? _studentError(themeProvider.isDark)
                            : _studentNotAdded(themeProvider.isDark);
                      }
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showBirthDatePicker() async {
    DateTime? pickeDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime.now(),
    );
    if (pickeDate != null) {
      setState(() {
        _dateOfBirth = pickeDate;
      });
    }
  }

  _showRegistrationDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dateOfRegister = pickedDate;
      });
    }
  }

  void _studentAdded(bool isDark) {
    final notifier = Provider.of<StudentProvider>(context, listen: false);
    final notifierHistorial =
        Provider.of<RegisterReportsProvider>(context, listen: false);
    GeneralWidgets.showSnackBar(context, 'Estudiante registrado', isDark);
    notifier.getStudents();
    notifierHistorial.getHistorialRegisters();
    Navigator.pop(context);
  }

  _studentError(bool isDark) {
    GeneralWidgets.showSnackBar(
        context, 'Error al registrar el estudiante', isDark);
  }

  _studentNotAdded(bool isDark) {
    GeneralWidgets.showSnackBar(
        context, 'No se pudo registrar el estudiante', isDark);
  }
}
