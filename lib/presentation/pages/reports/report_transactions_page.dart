import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/utils/conversors.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:komando_swimming_club/presentation/provider/transaction_report_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ReportTransactionsPage extends StatefulWidget {
  const ReportTransactionsPage({super.key});

  @override
  State<ReportTransactionsPage> createState() => _ReportTransactionsPageState();
}

class _ReportTransactionsPageState extends State<ReportTransactionsPage> {
  DateTime _initDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: Text(
                  Conversors.dateToString(_initDate),
                ),
                onPressed: () {
                  _selectInitDate();
                },
              ),
              TextButton(
                child: Text(
                  Conversors.dateToString(_endDate),
                ),
                onPressed: () {
                  _selectEndDate();
                },
              ),
              Consumer<ThemeStyleProvider>(
                  builder: (context, themeProvider, child) {
                return ElevatedButton.icon(
                  label: Text('Buscar'),
                  icon: Icon(
                    FontAwesomeIcons.searchengin,
                    color: themeProvider.isDark ? Colors.black : Colors.white,
                  ),
                  onPressed: () {
                    final notifier = Provider.of<TransactionReportProvider>(
                        context,
                        listen: false);
                    notifier.getTransactions(_initDate, _endDate);
                  },
                );
              })
            ],
          ),
          Expanded(
            child: Consumer<TransactionReportProvider>(
              builder: (context, transactionProvider, child) {
                final transactions = transactionProvider.transactions;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      return Consumer<ThemeStyleProvider>(
                        builder: (context, themeProvider, child) => ListTile(
                          tileColor: themeProvider.isDark
                              ? Colors.black
                              : Colors.white,
                          title: Text(transactions[index].description),
                          subtitle: Text(
                            Conversors.dateToString(transactions[index].date),
                            style: AppFonts.textReportSubItemStyle(),
                          ),
                          trailing: Text(
                            transactions[index].type == 'income'
                                ? transactions[index].amount.toString()
                                : (transactions[index].amount * -1).toString(),
                            style: AppFonts.textCardStyle(),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: Text(
                    'Seleccione fechas y buscar',
                    style: AppFonts.textCardStyle(),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<ThemeStyleProvider>(
                builder: (context, themeProvider, child) {
                  return Container(
                    height: 6.h,
                    width: 49.w,
                    color: themeProvider.isDark ? Colors.green : Colors.black,
                    child: Center(
                      child: Text(
                        'Monto total: ',
                        style: themeProvider.isDark
                            ? AppFonts.textCardTitleStyle()
                            : AppFonts.textCardTitleStyle()
                                .copyWith(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                width: 49.w,
                child: Consumer<TransactionReportProvider>(
                  builder: (context, transactionProvider, child) {
                    return Text(
                      transactionProvider.amount.toString(),
                      style: AppFonts.textCardTitleStyle(),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _selectInitDate() async {
    final tempDate = await showDatePicker(
      context: context,
      initialDate: _initDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );
    if (tempDate != null) {
      setState(() {
        _initDate = tempDate;
      });
    }
  }

  void _selectEndDate() async {
    final tempDate = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );
    if (tempDate != null) {
      setState(() {
        _endDate = tempDate;
      });
    }
  }
}
