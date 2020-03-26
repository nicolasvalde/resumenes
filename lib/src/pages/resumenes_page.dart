import 'package:flutter/material.dart';

class ResumenesPage extends StatelessWidget {
  final Map<String, Object> arguments;

  ResumenesPage(this.arguments);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombre de la materia'),
      ),
      body: Center(
        child: Container(
          child: Text('Acá van los resúmenes'),
        ),
      ),
    );
  }
}
