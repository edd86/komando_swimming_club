import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/core/utils/conversors.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TransactionCardWidget extends StatelessWidget {
  final Transactions transaction;
  const TransactionCardWidget({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeStyleProvider>(
      builder: (context, themeProvider, child) {
        return SizedBox(
          height: 8.h,
          child: Card(
            color: themeProvider.isDark ? Colors.black54 : Colors.white54,
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 57.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Conversors.dateToString(transaction.date),
                              style: AppFonts.textTransactionStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              Conversors.timeToString(transaction.date),
                              style: AppFonts.textTransactionStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Text(
                          transaction.description,
                          style: AppFonts.textCardStyle(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 29.w,
                    child: Text(
                      transaction.type == 'expense'
                          ? (transaction.amount * -1).toString()
                          : transaction.amount.toString(),
                      textAlign: TextAlign.right,
                      style: transaction.type == 'expense'
                          ? AppFonts.textTransactionExpenseAmountStyle()
                          : AppFonts.textTransactionIncomeAmountStyle(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
