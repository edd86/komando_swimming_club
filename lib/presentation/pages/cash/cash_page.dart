import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/presentation/provider/cash_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CashPage extends StatelessWidget {
  const CashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Consumer<CashProvider>(builder: (context, cashProvider, child) {
          final amount = cashProvider.amount;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 5.h,
                width: 50.w,
                color: amount > 0 ? Colors.green[800] : Colors.green[100],
                child: Center(
                  child: Text(
                    'Saldo',
                    style: amount > 0
                        ? AppFonts.textCashPositiveStyle()
                        : AppFonts.textCashNegativeStyle(),
                  ),
                ),
              ),
              SizedBox(
                width: 50.w,
                child: Text(
                  'Bs. ${amount.toStringAsFixed(2)}',
                  style: AppFonts.textCardTitleStyle(),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          );
        }),
        Expanded(
          child:
              Consumer<CashProvider>(builder: (context, cashProvider, child) {
            final transactions = cashProvider.transactions;
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(transactions[index].description),
                  trailing: Text(transactions[index].amount.toString(),),
                );
              },
            );
          }),
        )
      ],
    );
  }
}
