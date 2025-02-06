import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/utils/conversors.dart';
import 'package:komando_swimming_club/domain/entities/student.dart';
import 'package:sizer/sizer.dart';

class StudentCardWidget extends StatelessWidget {
  final Student student;
  const StudentCardWidget({required this.student, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[900],
      child: SizedBox(
        height: 20.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              student.name,
              style: AppFonts.textCardTitleStyle(),
            ),
            Text(
              student.ppff,
              style: AppFonts.textCardStyle(),
            ),
            Text(
              student.phone,
              style: AppFonts.textCardStyle(),
            ),
            Text(
              student.obs,
              style: AppFonts.textCardStyle(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    child: Row(
                  children: [
                    Icon(FontAwesomeIcons.cakeCandles),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      student.age.toString(),
                      style: AppFonts.textCardStyle(),
                    ),
                  ],
                )),
                SizedBox(
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.cakeCandles),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        Conversors.dateToString(student.dateOfBirth),
                        style: AppFonts.textCardStyle(),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Icon(Icons.start),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        Conversors.dateToString(student.dateOfRegister),
                        style: AppFonts.textCardStyle(),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
