import 'package:flutter/material.dart';

class ResumenesPage extends StatefulWidget {
  final Map<String, Object> arguments;

  ResumenesPage(this.arguments);

  @override
  _ResumenesPageState createState() => _ResumenesPageState();
}

class _ResumenesPageState extends State<ResumenesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: arguments['nombreMateria'],
        title: Text(widget.arguments['nombreMateria']),
      ),
      body: Center(
        child: Container(
          child: Text('Acá van los resúmenes'),
        ),
      ),
    );
  }
}
