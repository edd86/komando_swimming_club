import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:komando_swimming_club/core/constants/app_fonts.dart';
import 'package:komando_swimming_club/presentation/provider/proffesor_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/proffesor_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProffesorsPage extends StatelessWidget {
  ProffesorsPage({super.key});
  final int delay = 100;
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 6.h,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              label: Row(
                children: [
                  Icon(Icons.search),
                  Text(
                    'Buscar profesor',
                    style: AppFonts.textFieldStyle(),
                  ),
                ],
              ),
            ),
            onChanged: (value) {
              final notifier =
                  Provider.of<ProffesorProvider>(context, listen: false);
              if (value.isEmpty) {
                notifier.getProffesors();
              } else {
                notifier.searchProffesor(value);
              }
            },
          ),
        ),
        Expanded(
          child: Consumer<ProffesorProvider>(
            builder: (context, proffesorProvider, child) {
              final proffesors = proffesorProvider.proffesors;
              if (proffesors.isEmpty) {
                return Center(
                  child: Text('No hay profesores registrados',
                      style: AppFonts.textCardStyle()),
                );
              }
              return ListView.builder(
                itemCount: proffesors.length,
                itemBuilder: (context, index) {
                  return FadeIn(
                    delay: Duration(milliseconds: delay * (index + 1)),
                    child: ProffesorCardWidget(
                      proffesor: proffesors[index],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
