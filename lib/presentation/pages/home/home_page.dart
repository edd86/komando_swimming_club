import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komando_swimming_club/core/constants/app_routes.dart';
import 'package:komando_swimming_club/core/constants/global_variables.dart';
import 'package:komando_swimming_club/presentation/pages/cash/cash_page.dart';
import 'package:komando_swimming_club/presentation/pages/proffesor/proffesors_page.dart';
import 'package:komando_swimming_club/presentation/pages/student/students_page.dart';
import 'package:komando_swimming_club/presentation/widgets/general_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralWidgets.customAppBar(context, 'Komando Swimming Club'),
      drawer: Drawer(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        destinations: Destinations.destinations
            .map((destiny) => NavigationDestination(
                  icon: Icon(destiny.icon),
                  label: destiny.label,
                  selectedIcon: Icon(destiny.iconSelected),
                ))
            .toList(),
        onDestinationSelected: (value) => setState(() {
          _currentIndex = value;
        }),
      ),

      ///Pages from the bottom
      body: <Widget>[
        ProffesorsPage(),
        StudentsPage(),
        CashPage(),
      ][_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            heroTag: 'btnPersons',
            child: Icon(Icons.person_add),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.registerPersonsRoute);
            },
          ),
          FloatingActionButton(
            heroTag: 'btnMoney',
            child: Icon(FontAwesomeIcons.moneyCheckDollar),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
