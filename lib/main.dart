import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:komando_swimming_club/core/constants/app_routes.dart';
import 'package:komando_swimming_club/core/constants/app_theme.dart';
import 'package:komando_swimming_club/data/data_sources/db_helper.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DbHelper dbHelper = DbHelper();
  final db = await dbHelper.db;
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<ThemeStyleProvider>(
                  create: (context) => ThemeStyleProvider(),
                )
              ],
              child: const MainApp(),
            ),
          ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Consumer<ThemeStyleProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
        title: 'Komando Swimming Club',
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashRoute,
        theme: themeProvider.isDark ? AppTheme.dark : AppTheme.light,
      );
      });
    });
  }
}
