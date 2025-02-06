import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/utils/conversors.dart';
import 'package:komando_swimming_club/core/utils/utils.dart';
import 'package:komando_swimming_club/data/data_sources/db_helper.dart';
import 'package:komando_swimming_club/data/repositories/student_repository_impl.dart';
import 'package:komando_swimming_club/domain/entities/proffesor.dart';
import 'package:komando_swimming_club/domain/entities/student.dart';
import 'package:komando_swimming_club/presentation/provider/proffesor_provider.dart';
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
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
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
            SizedBox(
              height: 3.h,
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
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
            SizedBox(
              height: 3.h,
            ),
            TextFormField(
              controller: _ppffController,
              textCapitalization: TextCapitalization.words,
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
            SizedBox(
              height: 3.h,
            ),
            TextFormField(
              controller: _obsController,
              textCapitalization: TextCapitalization.sentences,
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
            SizedBox(
              height: 4.h,
            ),
            Consumer<ProffesorProvider>(
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
                  items:
                      proffesors.map<DropdownMenuItem<Proffesor>>((proffesor) {
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
            SizedBox(
              height: 4.h,
            ),
            Row(
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
            Consumer<ThemeStyleProvider>(
              builder: (context, value, child) => ElevatedButton.icon(
                label: Text('Registrar Estudiante'),
                icon: Icon(
                  Icons.save,
                  color: value.isDark ? Colors.black : Colors.white,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final studentRepo =
                        StudentRepositoryImpl(db: await DbHelper().db);
                    final newStundent = Student(
                      name: _nameController.text,
                      phone: _phoneController.text,
                      dateOfBirth: _dateOfBirth,
                      dateOfRegister: _dateOfRegister,
                      age: Utils().calculateAge(_dateOfBirth),
                      obs: _obsController.text,
                      ppff: _ppffController.text,
                      profesorId: _selectedProffesor!.id!,
                    );
                    final student = await studentRepo.addStudent(newStundent);
                    if (student != null && student.id != null) {
                      _studentAdded();
                    } else {
                      student == null ? _studentError() : _studentNotAdded();
                    }
                  }
                },
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

  void _studentAdded() {
    GeneralWidgets.showSnackBar(context, 'Estudiante registrado');
    final notifier = Provider.of<StudentProvider>(context, listen: false);
    notifier.getStudents();
    Navigator.pop(context);
  }

  _studentError() {
    GeneralWidgets.showSnackBar(context, 'Error al registrar el estudiante');
  }

  _studentNotAdded() {
    GeneralWidgets.showSnackBar(context, 'No se pudo registrar el estudiante');
  }
}
