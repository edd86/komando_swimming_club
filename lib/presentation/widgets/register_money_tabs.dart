import 'package:flutter/material.dart';
import 'package:komando_swimming_club/presentation/pages/register/register_incomme_page.dart';

class RegisterMoneyTabs extends StatelessWidget {
  const RegisterMoneyTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Transacciones'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Ingreso'),
              Tab(text: 'Egreso'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RegisterIncommePage(),
            Container(),
          ],
        ),
      ),
    );
  }
}
