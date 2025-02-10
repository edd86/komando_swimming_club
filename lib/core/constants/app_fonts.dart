import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppFonts {
  static titleStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 20.sp,
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

  static textCashPositiveStyle() => GoogleFonts.firaSansCondensed(
      fontSize: 16.5.sp, fontWeight: FontWeight.w600, color: Colors.white);

  static textCashNegativeStyle() => GoogleFonts.firaSansCondensed(
      fontSize: 16.5.sp, fontWeight: FontWeight.w600, color: Colors.red);

  static textTransactionStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
      );

  static textTransactionExpenseAmountStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
        color: Colors.red,
      );

  static textTransactionIncomeAmountStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
      );

  static textDrawerStyle() => GoogleFonts.firaSansCondensed(
        fontSize: 13.5.sp,
        fontWeight: FontWeight.bold,
      );

  static textReportItemStyle() => GoogleFonts.firaSansCondensed(
      fontSize: 13.sp, fontWeight: FontWeight.bold);

  static textReportSubItemStyle() => GoogleFonts.firaSansCondensed(
      fontSize: 13.sp, fontWeight: FontWeight.w400);
}
