import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/domain/entities/user.dart';

String secretCode = 'Kom@ndo';
User? userLogged;

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
