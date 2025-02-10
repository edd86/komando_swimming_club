import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/utils/conversors.dart';
import 'package:komando_swimming_club/presentation/provider/register_reports_provider.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:provider/provider.dart';

class ReportRegistersPage extends StatelessWidget {
  const ReportRegistersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegisterReportsProvider>(
        builder: (context, registerProvider, child) {
          final historialRegisters = registerProvider.historialRegisters;
          if (historialRegisters.isEmpty) {
            return Center(
              child: Text('No hay registros'),
            );
          }
          return ListView.builder(
            itemCount: historialRegisters.length,
            itemBuilder: (context, index) {
              return Consumer<ThemeStyleProvider>(
                builder: (context, themeProvider, child) {
                  return ListTile(
                    tileColor:
                        themeProvider.isDark ? Colors.black : Colors.white,
                    title: Text(
                      '${historialRegisters[index].name} - ${historialRegisters[index].action}',
                      style: AppFonts.textReportItemStyle(),
                    ),
                    subtitle: Text(
                      Conversors.dateToString(historialRegisters[index].date),
                      style: AppFonts.textReportSubItemStyle(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
