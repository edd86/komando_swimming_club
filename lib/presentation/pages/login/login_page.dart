import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/constants/app_routes.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscureText = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Komando Swimming Club',
              style: AppFonts.titleStyle(),
            ),
            SizedBox(
              height: 5.h,
            ),
            Image.asset(
              'assets/images/icono.png',
              height: 20.h,
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              height: 35.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          label: Row(
                            children: [
                              Icon(Icons.person),
                              Text(
                                'Nombre de usuario',
                                style: AppFonts.textFieldStyle(),
                              ),
                            ],
                          ),
                        ),
                        style: AppFonts.textFieldStyle(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, introduce un nombre de usuario';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isObscureText,
                        decoration: InputDecoration(
                          label: Row(
                            children: [
                              Icon(Icons.lock),
                              Text(
                                'Contraseña',
                                style: AppFonts.textFieldStyle(),
                              ),
                            ],
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscureText = !_isObscureText;
                              });
                            },
                          ),
                        ),
                        style: AppFonts.textFieldStyle(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, introduce una contraseña';
                          }
                          return null;
                        },
                      ),
                      Consumer<ThemeStyleProvider>(
                          builder: (context, themeProvider, child) {
                        return ElevatedButton.icon(
                          label: Text('Iniciar sesión'),
                          icon: Icon(
                            Icons.login_rounded,
                            color: themeProvider.isDark
                                ? Colors.black
                                : Colors.white,
                          ),
                          onPressed: () {},
                        );
                      }),
                      TextButton(
                        child: Text('Registrarse'),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRoutes.registerUserRoute,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Consumer<ThemeStyleProvider>(
                builder: (contex, themeProvider, child) {
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
            })
          ],
        ),
      ),
    );
  }
}
