import 'package:flutter/material.dart';

class GeneralWidgets {
  static showSnackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green[800],
        ),
      );

  static customAppBar(BuildContext context, String title) => AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 5,
      );
}
