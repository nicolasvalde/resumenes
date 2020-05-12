import 'package:flutter/material.dart';
import 'package:resumenes/src/providers/facultades_provider.dart';
import 'package:resumenes/src/providers/materias_provider.dart';
import 'package:resumenes/src/widgets/CTNoAvatar.dart';

class MateriasPage extends StatefulWidget {
  // MateriasPage({Key key, this.title}) : super(key: key);

  final Map<String, Object> arguments;

  MateriasPage(this.arguments);

  @override
  _MateriasPageState createState() => _MateriasPageState();
}

class _MateriasPageState extends State<MateriasPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.arguments['nombreCarrera']),
        actions: <Widget>[],
      ),
      body: _lista(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: materiasProvider.cargarData(
          widget.arguments['nombreUniversidad'],
          widget.arguments['nombreFacultad'],
          widget.arguments['nombreCarrera']),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listaItems(snapshot.data),
          padding: EdgeInsets.symmetric(vertical: 8),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data) {
    final List<Widget> materias = [];
    if (data != null) {
      data.forEach((m) {
        final widgetTemp = CustomTileNoAvatar('materias',
            nombreUniversidad: widget.arguments['nombreUniversidad'],
            nombreFacultad: widget.arguments['nombreFacultad'],
            nombreCarrera: widget.arguments['nombreCarrera'],
            nombreMateria: m['nombre']);
        materias.add(widgetTemp);
        // facultades.add(Divider());
      });
    }

    return materias;
  }
}
