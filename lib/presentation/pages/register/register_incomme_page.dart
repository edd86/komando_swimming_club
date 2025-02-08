import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/data/data_sources/db_helper.dart';
import 'package:komando_swimming_club/data/repositories/cash_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/historical_register_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/incomme_repository_impl.dart';
import 'package:komando_swimming_club/domain/entities/cash.dart';
import 'package:komando_swimming_club/domain/entities/historial_register.dart';
import 'package:komando_swimming_club/domain/entities/incomme.dart';
import 'package:komando_swimming_club/presentation/provider/cash_provider.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/general_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterIncommePage extends StatefulWidget {
  const RegisterIncommePage({super.key});

  @override
  State<RegisterIncommePage> createState() => _RegisterIncommePageState();
}

class _RegisterIncommePageState extends State<RegisterIncommePage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _obsController = TextEditingController();
  final DateTime _date = DateTime.now();
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FadeInLeft(
              delay: Duration(milliseconds: _delay * 2),
              child: TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: AppFonts.textFieldStyle(),
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(Icons.attach_money),
                      Text(
                        'Monto',
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un monto';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            FadeInLeft(
              delay: Duration(milliseconds: _delay * 3),
              child: TextFormField(
                controller: _obsController,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                style: AppFonts.textFieldStyle(),
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(FontAwesomeIcons.info),
                      Text(
                        'Observaciones',
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            FadeIn(
              delay: Duration(milliseconds: _delay * 4),
              child: Consumer<ThemeStyleProvider>(
                builder: (context, themeProvider, child) => ElevatedButton.icon(
                  label: Text('Registrar Ingreso'),
                  icon: Icon(
                    Icons.save,
                    color: themeProvider.isDark ? Colors.black : Colors.white,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final incommeRepo =
                          IncommeRepositoryImpl(db: await DbHelper().db);
                      final cashRepo =
                          CashRepositoryImpl(db: await DbHelper().db);
                      final incomme = await incommeRepo.addIncomme(Incomme(
                        date: _date,
                        amount: double.parse(_amountController.text),
                        obs: _obsController.text,
                        cajaId: 1,
                      ));
                      if (incomme != null) {
                        if (incomme.id != null) {
                          final cash = await cashRepo.getCash();
                          if (cash != null) {
                            await cashRepo.updateCashAmount(incomme.amount);
                            final historialRegisterRepo =
                                HistorialRegisterRepositoryImpl(
                                    db: await DbHelper().db);
                            await historialRegisterRepo.addHistorialRegister(
                                HistorialRegister(
                                    date: _date,
                                    action:
                                        'Ingreso, ${incomme.amount.toStringAsFixed(2)}',
                                    userId: userLogged!.id!,
                                    ingressId: incomme.id));
                            _incommeAdded(themeProvider.isDark);
                          } else {
                            final newCash = Cash(
                              amount: 0 + incomme.amount,
                            );
                            await cashRepo.addCash(newCash);
                            final historialRegisterRepo =
                                HistorialRegisterRepositoryImpl(
                                    db: await DbHelper().db);
                            await historialRegisterRepo.addHistorialRegister(
                                HistorialRegister(
                                    date: _date,
                                    action:
                                        'Ingreso, ${incomme.amount.toStringAsFixed(2)}',
                                    userId: userLogged!.id!,
                                    ingressId: incomme.id));
                            _incommeAdded(themeProvider.isDark);
                          }
                        } else {
                          _incommeNotAdded(themeProvider.isDark);
                        }
                      } else {
                        _incommeNull(themeProvider.isDark);
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _incommeAdded(bool isDark) {
    GeneralWidgets.showSnackBar(context, 'Ingreso registrado', isDark);
    final notifier = Provider.of<CashProvider>(context, listen: false);
    notifier.getTransactions();
    notifier.getAmount();
    Navigator.pop(context);
  }

  void _incommeNull(bool isDark) {
    GeneralWidgets.showSnackBar(
        context, 'Error al registrar el ingreso', isDark);
  }

  void _incommeNotAdded(bool isDark) {
    GeneralWidgets.showSnackBar(
        context, 'No se pudo registrar el ingreso', isDark);
  }
}
