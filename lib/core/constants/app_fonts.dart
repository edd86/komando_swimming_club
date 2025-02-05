import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppFonts {
  static titleStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 25.sp,
        fontWeight: FontWeight.w700,
      );

  static textFieldStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
      );
}
