import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 50.w,
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                SizedBox(
                  height: 11.h,
                  child: Image.asset('assets/images/logo_comando.png'),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  userLogged!.name,
                  style: AppFonts.textDrawerStyle(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (context, index) {
                return Consumer<ThemeStyleProvider>(
                    builder: (context, themeProvider, child) {
                  return ListTile(
                    tileColor:
                        themeProvider.isDark ? Colors.black : Colors.white,
                    leading: Icon(
                      drawerItems[index].icon,
                      size: 17.sp,
                    ),
                    title: Text(drawerItems[index].label,
                        style: AppFonts.textDrawerStyle()),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pushNamed(context, drawerItems[index].route);
                    },
                  );
                });
              },
            ),
          ),
          Center(
            child: Consumer<ThemeStyleProvider>(
                builder: (context, themeProvider, child) {
              return IconButton.filled(
                icon: themeProvider.isDark
                    ? Icon(Icons.light_mode_outlined)
                    : Icon(Icons.dark_mode_outlined),
                onPressed: () {
                  final provider =
                      Provider.of<ThemeStyleProvider>(context, listen: false);
                  provider.isDark = !provider.isDark;
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
