import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/data/data_sources/db_helper.dart';
import 'package:komando_swimming_club/data/repositories/user_repository_impl.dart';
import 'package:komando_swimming_club/domain/entities/user.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/general_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _secretCodeController = TextEditingController();
  bool _isObscureText = true;
  int delay = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Usuario'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          child: Column(
            children: [
              FadeInLeft(
                delay: Duration(milliseconds: delay * 2),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    label: Row(
                      children: [
                        Icon(Icons.person),
                        Text(
                          'Nombre Completo',
                          style: AppFonts.textFieldStyle(),
                        ),
                      ],
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce un nombre completo';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              FadeInLeft(
                delay: Duration(milliseconds: delay * 3),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    label: Row(
                      children: [
                        Icon(Icons.phone),
                        Text(
                          'Número de teléfono',
                          style: AppFonts.textFieldStyle(),
                        ),
                      ],
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce un número de teléfono';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              FadeInLeft(
                delay: Duration(milliseconds: delay * 4),
                child: TextFormField(
                  controller: _userNameController,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce un nombre de usuario';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              FadeInLeft(
                delay: Duration(milliseconds: delay * 5),
                child: TextFormField(
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
                  style: TextStyle(fontSize: 15.sp),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce una contraseña';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              FadeInLeft(
                delay: Duration(milliseconds: delay * 6),
                child: TextFormField(
                  controller: _secretCodeController,
                  decoration: InputDecoration(
                    label: Row(
                      children: [
                        Icon(Icons.lock_person),
                        Text(
                          'Código de verificación',
                          style: AppFonts.textFieldStyle(),
                        ),
                      ],
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Introduce un código de verificación';
                    }
                    if (value != secretCode) {
                      return 'Introduce un código de verificación correcto';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              FadeInUp(
                delay: Duration(milliseconds: delay * 7),
                child: Consumer<ThemeStyleProvider>(
                    builder: (context, themeProvider, child) {
                  return ElevatedButton.icon(
                    icon: Icon(
                      Icons.save,
                      color: themeProvider.isDark ? Colors.black : Colors.white,
                    ),
                    label: Text(
                      'Registrar Usuario',
                      style: AppFonts.textButtonStyle(),
                    ),
                    onPressed: () async {
                      final userRepo =
                          UserRepositoryImpl(db: await DbHelper().db);
                      if (_formKey.currentState!.validate()) {
                        final newUser = User(
                          name: _nameController.text,
                          phone: _phoneController.text,
                          userName: _userNameController.text,
                          password: _passwordController.text,
                        );
                        final user = await userRepo.addUser(newUser);
                        if (user != null) {
                          _userAdded(user);
                        } else {
                          _userError();
                        }
                      }
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _userAdded(User user) {
    GeneralWidgets.showSnackBar(context, 'Usuario ${user.userName} registrado');
    Navigator.pop(context);
  }

  void _userError() {
    GeneralWidgets.showSnackBar(context, 'Error al registrar el usuario');
  }
}
