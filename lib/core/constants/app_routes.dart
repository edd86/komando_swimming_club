import 'package:flutter/material.dart';
import 'package:komando_swimming_club/presentation/pages/home/home_page.dart';
import 'package:komando_swimming_club/presentation/pages/login/login_page.dart';
import 'package:komando_swimming_club/presentation/pages/login/splash_page.dart';
import 'package:komando_swimming_club/presentation/pages/register/register_user_page.dart';
import 'package:komando_swimming_club/presentation/pages/reports/report_registers_page.dart';
import 'package:komando_swimming_club/presentation/pages/reports/report_transactions_page.dart';
import 'package:komando_swimming_club/presentation/pages/user/user_page.dart';
import 'package:komando_swimming_club/presentation/widgets/register_money_tabs.dart';
import 'package:komando_swimming_club/presentation/widgets/register_persons_tabs.dart';

class AppRoutes {
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String splashRoute = '/splash';
  static const String registerUserRoute = '/registerUser';
  static const String registerPersonsRoute = '/registerPersons';
  static const String registerMoneyRoute = '/registerMoney';
  static const String userProfileRoute = '/profile';
  static const String reportRegistersRoute = '/reportRegisters';
  static const String reportTransactionsRoute = '/reportTransactions';

  static Map<String, WidgetBuilder> get routes {
    return {
      homeRoute: (context) => const HomePage(),
      loginRoute: (context) => const LoginPage(),
      splashRoute: (context) => const SplashPage(),
      registerUserRoute: (context) => const RegisterUserPage(),
      registerPersonsRoute: (context) => const RegisterPersonsTabs(),
      registerMoneyRoute: (context) => const RegisterMoneyTabs(),
      userProfileRoute: (context) => const UserPage(),
      reportRegistersRoute: (context) => const ReportRegistersPage(),
      reportTransactionsRoute: (context) => const ReportTransactionsPage(),
    };
  }
}
