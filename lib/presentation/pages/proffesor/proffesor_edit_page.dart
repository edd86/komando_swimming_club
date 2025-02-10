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

class ProffesorEditPage extends StatefulWidget {
  final Proffesor proffesor;
  const ProffesorEditPage({required this.proffesor, super.key});

  @override
  State<ProffesorEditPage> createState() => _ProffesorEditPageState();
}

class _ProffesorEditPageState extends State<ProffesorEditPage> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _obsController = TextEditingController();
  late DateTime _dateOfBirth;
  late DateTime _beginDate;

  @override
  void initState() {
    _nameController.text = widget.proffesor.name;
    _phoneController.text = widget.proffesor.phone;
    _obsController.text = widget.proffesor.obs ?? '';
    _dateOfBirth = widget.proffesor.dateOfBirth;
    _beginDate = widget.proffesor.beginDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralWidgets.customAppBar(context, 'Editar Profesor'),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 2.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                style: AppFonts.textFieldStyle(),
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Nombre Completo',
                        style: AppFonts.textFieldStyle(),
                      ),
                    ],
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es requerido';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 3.h,
              ),
              TextFormField(
                controller: _phoneController,
                style: AppFonts.textFieldStyle(),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(FontAwesomeIcons.mobile),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Teléfono',
                        style: AppFonts.textFieldStyle(),
                      ),
                    ],
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El teléfono es requerido';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 3.h,
              ),
              TextFormField(
                controller: _obsController,
                style: AppFonts.textFieldStyle(),
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(FontAwesomeIcons.info),
                      SizedBox(
                        width: 5.w,
                      ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.cake),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          Conversors.dateToString(_dateOfBirth),
                          style: AppFonts.textFieldStyle(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          Conversors.dateToString(_beginDate),
                          style: AppFonts.textFieldStyle(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Consumer<ThemeStyleProvider>(
                builder: (context, themeProvider, child) => ElevatedButton.icon(
                  label: Text('Editar Profesor'),
                  icon: Icon(
                    FontAwesomeIcons.floppyDisk,
                    color: themeProvider.isDark ? Colors.black : Colors.white,
                  ),
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      final proffesorRepo =
                          ProffessorRepositoryImpl(db: await DbHelper().db);
                      final cont = await proffesorRepo.updateProffesor(
                          Proffesor(
                              id: widget.proffesor.id,
                              name: _nameController.text,
                              age: Utils().calculateAge(_dateOfBirth),
                              phone: _phoneController.text,
                              obs: _obsController.text,
                              dateOfBirth: _dateOfBirth,
                              beginDate: _beginDate));
                      if (cont != null && cont > 0) {
                        final historial = HistorialRegisterRepositoryImpl(
                            db: await DbHelper().db);
                        await historial.addHistorialRegister(HistorialRegister(
                          date: DateTime.now(),
                          action: 'Editado Profesor, $_nameController.text',
                          userId: userLogged!.id!,
                          profesorId: widget.proffesor.id,
                        ));
                        _proffesorChanges(themeProvider.isDark);
                      } else {
                        cont == null
                            ? _proffesorWOchanges(themeProvider.isDark)
                            : _proffesorError(themeProvider.isDark);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _proffesorChanges(bool isDark) {
    final proffesorNotifier =
        Provider.of<ProffesorProvider>(context, listen: false);
    final registerNotifier =
        Provider.of<RegisterReportsProvider>(context, listen: false);
    proffesorNotifier.getProffesors();
    registerNotifier.getHistorialRegisters();
    GeneralWidgets.showSnackBar(context, 'Cambios guardados', isDark);
    Navigator.pop(context);
  }

  void _proffesorWOchanges(bool isDark) {
    GeneralWidgets.showSnackBar(context, 'Cambios no guardados', isDark);
  }

  void _proffesorError(bool isDark) {
    GeneralWidgets.showSnackBar(context, 'Error al guardar cambios', isDark);
  }
}
