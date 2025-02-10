import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/utils/conversors.dart';
import 'package:komando_swimming_club/data/data_sources/db_helper.dart';
import 'package:komando_swimming_club/data/repositories/assitance_repository_impl.dart';
import 'package:komando_swimming_club/domain/entities/assistance.dart';
import 'package:komando_swimming_club/domain/entities/proffesor.dart';
import 'package:komando_swimming_club/presentation/pages/proffesor/proffesor_edit_page.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/assistant_dialog_widget.dart';
import 'package:komando_swimming_club/presentation/widgets/general_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProffesorCardWidget extends StatelessWidget {
  final Proffesor proffesor;
  const ProffesorCardWidget({required this.proffesor, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeStyleProvider>(
      builder: (context, themeProvider, child) {
        return Card(
          color: themeProvider.isDark ? Colors.green[900] : Colors.green[200],
          child: Stack(
            children: [
              SizedBox(
                height: 19.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 3.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        proffesor.name,
                        style: AppFonts.textCardTitleStyle(),
                      ),
                      Text(
                        proffesor.phone,
                        style: AppFonts.textCardStyle(),
                      ),
                      Text(
                        proffesor.obs != null ? proffesor.obs! : '',
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
                                  proffesor.age.toString(),
                                  style: AppFonts.textCardStyle(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.cakeCandles),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  Conversors.dateToString(
                                      proffesor.dateOfBirth),
                                  style: AppFonts.textCardStyle(),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                Icon(Icons.start_rounded),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  Conversors.dateToString(proffesor.beginDate),
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
              ),
              MenuAnchor(
                menuChildren: [
                  MenuItemButton(
                    child: Text(
                      'Asistencia',
                      style: AppFonts.textMenuAnchorStyle(),
                    ),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (_) =>
                            AssistantDialogWidget(proffesor: proffesor)),
                  ),
                  MenuItemButton(
                    child: Text(
                      'Salida',
                      style: AppFonts.textMenuAnchorStyle(),
                    ),
                    onPressed: () async {
                      final assitanceRepo =
                          AssitanceRepositoryImpl(db: await DbHelper().db);
                      final assistanceOut = Assistance(
                        dateOut: DateTime.now(),
                        proffesorId: proffesor.id!,
                        state: 'presente',
                      );
                      final id = await assitanceRepo
                          .editTeacherAssitanceOut(assistanceOut);
                      if (id != null && id > 0) {
                        GeneralWidgets.showSnackBar(
                            context,
                            'Asistencia de salida registrada',
                            themeProvider.isDark);
                      } else {
                        GeneralWidgets.showSnackBar(
                            context,
                            'No tiene asistencia de entrada',
                            themeProvider.isDark);
                      }
                    },
                  ),
                  MenuItemButton(
                    child: Text(
                      'Editar',
                      style: AppFonts.textMenuAnchorStyle(),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProffesorEditPage(proffesor: proffesor),
                      ),
                    ),
                  ),
                  MenuItemButton(
                    child: Text(
                      'Eliminar',
                      style: AppFonts.textMenuAnchorStyle(),
                    ),
                    onPressed: () {},
                  ),
                ],
                builder: (_, controller, child) {
                  return IconButton(
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    icon: Icon(Icons.more_vert),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
