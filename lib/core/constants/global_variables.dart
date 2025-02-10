import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/core/constants/app_routes.dart';
import 'package:komando_swimming_club/domain/entities/historial_register.dart';
import 'package:komando_swimming_club/domain/entities/user.dart';

String secretCode = 'Kom@ndo';
User? userLogged;

class HistorialRegisterTile extends HistorialRegister {
  String name;

  HistorialRegisterTile({
    required this.name,
    required super.date,
    required super.action,
    required super.userId,
  });
}

class Destinations {
  IconData iconSelected;
  String label;
  IconData icon;

  Destinations({
    required this.iconSelected,
    required this.label,
    required this.icon,
  });

  static List<Destinations> destinations = [
    Destinations(
      iconSelected: FontAwesomeIcons.personSwimming,
      label: 'Profesores',
      icon: FontAwesomeIcons.personSwimming,
    ),
    Destinations(
      iconSelected: FontAwesomeIcons.children,
      label: 'Estudiantes',
      icon: FontAwesomeIcons.child,
    ),
    Destinations(
      icon: FontAwesomeIcons.moneyBillTransfer,
      label: 'Dinero',
      iconSelected: FontAwesomeIcons.moneyBillTransfer,
    ),
  ];
}

class Transactions {
  double amount;
  DateTime date;
  String description;
  String type;

  Transactions({
    required this.amount,
    required this.date,
    required this.description,
    required this.type,
  });
}

class DrawerItem {
  IconData icon;
  String label;
  String route;

  DrawerItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

List<DrawerItem> drawerItems = [
  DrawerItem(
    icon: FontAwesomeIcons.user,
    label: 'Perfil',
    route: AppRoutes.userProfileRoute,
  ),
  DrawerItem(
    icon: FontAwesomeIcons.clipboardList,
    label: 'Reporte de registros',
    route: AppRoutes.reportRegistersRoute,
  ),
  DrawerItem(
    icon: FontAwesomeIcons.moneyBillTransfer,
    label: 'Transacciones',
    route: AppRoutes.reportTransactionsRoute,
  )
];
