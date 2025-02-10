import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';

class GeneralWidgets {
  static showSnackBar(BuildContext context, String message, bool isDart) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green[800],
        ),
      );

  static customAppBar(BuildContext context, String title) => AppBar(
        title: Text(title, style: AppFonts.titleStyle()),
        centerTitle: true,
        elevation: 5,
      );
}
