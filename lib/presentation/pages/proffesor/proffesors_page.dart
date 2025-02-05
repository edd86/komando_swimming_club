import 'package:flutter/material.dart';
import 'package:komando_swimming_club/presentation/provider/proffesor_provider.dart';
import 'package:provider/provider.dart';

class ProffesorsPage extends StatelessWidget {
  const ProffesorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProffesorProvider>(
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
              return Card(
                child: ListTile(
                  title: Text(
                    proffesors[index].name,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
