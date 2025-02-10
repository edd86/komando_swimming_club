import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/core/utils/conversors.dart';
import 'package:komando_swimming_club/core/utils/utils.dart';
import 'package:komando_swimming_club/data/data_sources/db_helper.dart';
import 'package:komando_swimming_club/data/repositories/historical_register_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/proffessor_repository_impl.dart';
import 'package:komando_swimming_club/domain/entities/historial_register.dart';
import 'package:komando_swimming_club/domain/entities/proffesor.dart';
import 'package:komando_swimming_club/presentation/provider/proffesor_provider.dart';
import 'package:komando_swimming_club/presentation/provider/register_reports_provider.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/general_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterProffesorPage extends StatefulWidget {
  const RegisterProffesorPage({super.key});

  @override
  State<RegisterProffesorPage> createState() => _RegisterProffesorPageState();
}

class _RegisterProffesorPageState extends State<RegisterProffesorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _obsController = TextEditingController();
  DateTime _dateOfBirth = DateTime.now();
  DateTime _beginDate = DateTime.now();
  int delay = 100;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _obsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        child: Column(
          children: [
            FadeInLeft(
              delay: Duration(milliseconds: delay * 2),
              child: TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                style: AppFonts.textFieldStyle(),
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(Icons.person),
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
            FadeInLeft(
              delay: Duration(milliseconds: delay * 3),
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: AppFonts.textFieldStyle(),
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(Icons.phone_android),
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
            FadeInLeft(
              delay: Duration(milliseconds: delay * 4),
              child: TextFormField(
                maxLines: 3,
                controller: _obsController,
                textCapitalization: TextCapitalization.sentences,
                style: AppFonts.textFieldStyle(),
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(Icons.info),
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
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FadeInLeft(
                  delay: Duration(milliseconds: delay * 5),
                  child: SizedBox(
                    height: 10.h,
                    child: Column(children: [
                      Icon(FontAwesomeIcons.cakeCandles),
                      TextButton(
                        child: Text(
                          Conversors.dateToString(_dateOfBirth),
                          style: AppFonts.textButtonStyle(),
                        ),
                        onPressed: () {
                          _showCalendarBthCalendar();
                        },
                      ),
                    ]),
                  ),
                ),
                FadeInRight(
                  delay: Duration(milliseconds: delay * 5),
                  child: SizedBox(
                    height: 10.h,
                    child: Column(children: [
                      Icon(Icons.start),
                      TextButton(
                        child: Text(
                          Conversors.dateToString(_beginDate),
                          style: AppFonts.textButtonStyle(),
                        ),
                        onPressed: () {
                          _showStartCalendar();
                        },
                      ),
                    ]),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            FadeIn(
              delay: Duration(milliseconds: delay * 6),
              child: Consumer<ThemeStyleProvider>(
                builder: (context, themeProvider, child) => ElevatedButton.icon(
                  label: Text('Registrar Profesor'),
                  icon: Icon(
                    FontAwesomeIcons.personCirclePlus,
                    color: themeProvider.isDark ? Colors.black : Colors.white,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final proffeRepo =
                          ProffessorRepositoryImpl(db: await DbHelper().db);
                      final newProffesor = Proffesor(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        dateOfBirth: _dateOfBirth,
                        beginDate: _beginDate,
                        obs: _obsController.text,
                        age: Utils().calculateAge(_dateOfBirth),
                      );
                      final proffesor =
                          await proffeRepo.addProffesor(newProffesor);
                      if (proffesor != null && proffesor.id != null) {
                        final historialRegisterRepo =
                            HistorialRegisterRepositoryImpl(
                                db: await DbHelper().db);
                        final newhistorical = HistorialRegister(
                            date: DateTime.now(),
                            action: 'Registro Profesor, ${proffesor.name}',
                            userId: userLogged!.id!,
                            profesorId: proffesor.id);
                        await historialRegisterRepo
                            .addHistorialRegister(newhistorical);
                        _proffesorRegistered(themeProvider.isDark);
                      } else {
                        _proffesorNotRegistered(themeProvider.isDark);
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

  void _showStartCalendar() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        _beginDate = picked;
      });
    } else {
      _showCustomSnackBar(true, true);
    }
  }

  void _showCalendarBthCalendar() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 18250)),
      lastDate: DateTime.now().subtract(Duration(days: 3650)),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirth = picked;
      });
    } else {
      _showCustomSnackBar(false, false);
    }
  }

  void _showCustomSnackBar(bool bool, isDark) {
    bool
        ? GeneralWidgets.showSnackBar(
            context, 'Fecha de inicio inválida', isDark)
        : GeneralWidgets.showSnackBar(
            context, 'Fecha de nacimiento inválida', isDark);
  }

  void _proffesorRegistered(bool isDark) {
    final notifier = Provider.of<ProffesorProvider>(context, listen: false);
    final reportNotifier =
        Provider.of<RegisterReportsProvider>(context, listen: false);
    notifier.getProffesors();
    reportNotifier.getHistorialRegisters();
    GeneralWidgets.showSnackBar(context, 'Profesor registrado', isDark);
    Navigator.pop(context);
  }

  void _proffesorNotRegistered(bool isDark) {
    GeneralWidgets.showSnackBar(
        context, 'Error al registrar el profesor', isDark);
  }
}
