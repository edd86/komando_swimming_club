import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppFonts {
  static titleStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 23.sp,
        fontWeight: FontWeight.w700,
      );

  static textFieldStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
      );

  static textButtonStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      );

  static textCardTitleStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 16.5.sp,
        fontWeight: FontWeight.w700,
      );
  static textCardStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );
  static textMenuAnchorStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      );
}
