import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/data/data_sources/db_helper.dart';
import 'package:komando_swimming_club/data/repositories/cash_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/expense_repository_impl.dart';
import 'package:komando_swimming_club/data/repositories/historical_register_repository_impl.dart';
import 'package:komando_swimming_club/domain/entities/cash.dart';
import 'package:komando_swimming_club/domain/entities/expense.dart';
import 'package:komando_swimming_club/domain/entities/historial_register.dart';
import 'package:komando_swimming_club/presentation/provider/cash_provider.dart';
import 'package:komando_swimming_club/presentation/provider/register_reports_provider.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/general_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterExpensePage extends StatefulWidget {
  const RegisterExpensePage({super.key});

  @override
  State<RegisterExpensePage> createState() => _RegisterExpensePageState();
}

class _RegisterExpensePageState extends State<RegisterExpensePage> {
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
            FadeInRight(
              delay: Duration(milliseconds: _delay * 1),
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
                        style: AppFonts.textFieldStyle(),
                      )
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
            FadeInRight(
              delay: Duration(milliseconds: _delay * 2),
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
                        style: AppFonts.textFieldStyle(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            FadeIn(
              delay: Duration(milliseconds: _delay * 3),
              child: Consumer<ThemeStyleProvider>(
                builder: (context, themeProvider, child) => ElevatedButton.icon(
                  icon: Icon(
                    Icons.save,
                    color: themeProvider.isDark ? Colors.black : Colors.white,
                  ),
                  label: Text('Registrar Egreso'),
                  onPressed: () async {
                    final cashRepo =
                        CashRepositoryImpl(db: await DbHelper().db);
                    final cash = await cashRepo.getCash();
                    if (cash != null) {
                      final expenseRepo =
                          ExpenseRepositoryImpl(db: await DbHelper().db);
                      final expense = await expenseRepo.addExpense(
                        Expense(
                            date: _date,
                            amount: double.parse(_amountController.text),
                            obs: _obsController.text,
                            cashId: cash.id!),
                      );
                      if (expense != null && expense.id != null) {
                        final historicalRepo = HistorialRegisterRepositoryImpl(
                            db: await DbHelper().db);
                        await historicalRepo.addHistorialRegister(
                            HistorialRegister(
                                date: _date,
                                action:
                                    'registro de gasto ${expense.amount * -1}',
                                userId: userLogged!.id!,
                                egressId: expense.id!));
                        await cashRepo.updateCashAmount(expense.amount * -1);
                        _expeseRegistered(
                            'Gasto registrado', themeProvider.isDark);
                      } else {
                        _expeseNotRegistered(
                            'Error al registrar', themeProvider.isDark);
                      }
                    } else {
                      final newCash = await cashRepo.addCash(
                        Cash(
                          amount: double.parse(
                                _amountController.text,
                              ) *
                              -1,
                        ),
                      );
                      if (newCash != null) {
                        final expenseRepo =
                            ExpenseRepositoryImpl(db: await DbHelper().db);
                        final expense = await expenseRepo.addExpense(
                          Expense(
                            date: _date,
                            amount: double.parse(_amountController.text),
                            obs: _obsController.text,
                            cashId: newCash.id!,
                          ),
                        );
                        if (expense != null && expense.id != null) {
                          final historicalRepo =
                              HistorialRegisterRepositoryImpl(
                                  db: await DbHelper().db);
                          await historicalRepo.addHistorialRegister(
                              HistorialRegister(
                                  date: _date,
                                  action:
                                      'registro de gasto ${expense.amount * -1}',
                                  userId: userLogged!.id!,
                                  egressId: expense.id!));
                          _expeseRegistered(
                              'Gasto registrado', themeProvider.isDark);
                        } else {
                          _expeseNotRegistered(
                              'Error al registrar', themeProvider.isDark);
                        }
                      } else {
                        _expeseNotRegistered(
                            'Error al registrar', themeProvider.isDark);
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

  void _expeseRegistered(String message, bool isDark) {
    GeneralWidgets.showSnackBar(context, message, isDark);
    final cashNotifier = Provider.of<CashProvider>(context, listen: false);
    final registerReportsNotifier =
        Provider.of<RegisterReportsProvider>(context, listen: false);
    cashNotifier.getTransactions();
    cashNotifier.getAmount();
    registerReportsNotifier.getHistorialRegisters();
    Navigator.pop(context);
  }

  void _expeseNotRegistered(String message, bool isDark) {
    GeneralWidgets.showSnackBar(context, message, isDark);
  }
}
