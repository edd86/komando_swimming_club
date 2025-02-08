import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 50.w,
    );
  }
}
