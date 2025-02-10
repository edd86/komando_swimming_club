import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/data/data_sources/db_helper.dart';
import 'package:komando_swimming_club/data/repositories/user_repository_impl.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/general_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _nameTextEditingController = TextEditingController();
  final _phoneTextEditingController = TextEditingController();
  final _userNameTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final int _delay = 150;
  bool _isObscure = true;

  @override
  void initState() {
    _nameTextEditingController.text = userLogged!.name;
    _phoneTextEditingController.text = userLogged!.phone;
    _userNameTextEditingController.text = userLogged!.userName;
    _passwordTextEditingController.text = userLogged!.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralWidgets.customAppBar(context, 'Perfil'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 3.h,
            ),
            FadeInLeft(
              delay: Duration(milliseconds: _delay * 1),
              child: SizedBox(
                width: 70.w,
                child: TextField(
                  controller: _nameTextEditingController,
                  style: AppFonts.textCardTitleStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            FadeInLeft(
              delay: Duration(milliseconds: _delay * 2),
              child: SizedBox(
                width: 70.w,
                child: TextField(
                  controller: _phoneTextEditingController,
                  style: AppFonts.textCardTitleStyle(),
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            FadeInLeft(
              delay: Duration(milliseconds: _delay * 3),
              child: SizedBox(
                width: 70.w,
                child: TextField(
                  controller: _userNameTextEditingController,
                  style: AppFonts.textCardTitleStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            FadeInLeft(
              delay: Duration(milliseconds: _delay * 4),
              child: SizedBox(
                width: 70.w,
                child: TextField(
                  controller: _passwordTextEditingController,
                  obscureText: _isObscure,
                  style: AppFonts.textCardTitleStyle(),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                    icon: Icon(_isObscure
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            FadeIn(
              child: Consumer<ThemeStyleProvider>(
                builder: (context, themeProvider, child) => ElevatedButton.icon(
                  label: Text('Guardar Cambios'),
                  icon: Icon(
                    FontAwesomeIcons.floppyDisk,
                    color: themeProvider.isDark ? Colors.black : Colors.white,
                  ),
                  onPressed: () async {
                    userLogged!.name = _nameTextEditingController.text;
                    userLogged!.phone = _phoneTextEditingController.text;
                    userLogged!.userName = _userNameTextEditingController.text;
                    userLogged!.password = _passwordTextEditingController.text;
                    final userRepo =
                        UserRepositoryImpl(db: await DbHelper().db);
                    final cont = await userRepo.updateUser(userLogged!);
                    if (cont != null && cont > 0) {
                      _changeUserLogged(themeProvider.isDark);
                    } else {
                      _notChangeUserLogged(themeProvider.isDark);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _changeUserLogged(bool isDark) {
    GeneralWidgets.showSnackBar(
        context, 'Cambios guardados, por favor inicia sesion', isDark);
    Navigator.pop(context);
  }

  void _notChangeUserLogged(bool isDark) {
    GeneralWidgets.showSnackBar(context, 'Error al guardar cambios', isDark);
  }
}
