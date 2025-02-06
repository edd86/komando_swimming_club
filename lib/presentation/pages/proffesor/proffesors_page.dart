import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:komando_swimming_club/presentation/provider/proffesor_provider.dart';
import 'package:komando_swimming_club/presentation/widgets/proffesor_card_widget.dart';
import 'package:provider/provider.dart';

class ProffesorsPage extends StatelessWidget {
  const ProffesorsPage({super.key});
  final int delay = 100;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProffesorProvider>(
      builder: (context, proffesorProvider, child) {
        final proffesors = proffesorProvider.proffesors;
        if (proffesors.isEmpty) {
          return Center(
            child: Text('No hay profesores registrados'),
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
    );
  }
}
