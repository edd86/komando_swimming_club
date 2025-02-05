import 'package:flutter/material.dart';
import 'package:komando_swimming_club/presentation/provider/theme_style_provider.dart';
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
  bool _isObscureText = true;

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
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(Icons.person),
                      Text(
                        'Nombre Completo',
                        style: TextStyle(fontSize: 15.sp),
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
              SizedBox(
                height: 3.h,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(Icons.phone),
                      Text(
                        'Número de teléfono',
                        style: TextStyle(fontSize: 15.sp),
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
              SizedBox(
                height: 3.h,
              ),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(Icons.person),
                      Text(
                        'Nombre de usuario',
                        style: TextStyle(fontSize: 15.sp),
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
              SizedBox(
                height: 3.h,
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
                        style: TextStyle(fontSize: 15.sp),
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
              SizedBox(
                height: 6.h,
              ),
              Consumer<ThemeStyleProvider>(
                  builder: (context, themeProvider, child) {
                return ElevatedButton.icon(
                  icon: Icon(
                    Icons.save,
                    color: themeProvider.isDark ? Colors.black : Colors.white,
                  ),
                  label: Text('Registrar Usuario'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      
                    }
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
