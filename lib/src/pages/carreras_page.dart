import 'package:flutter/material.dart';
import 'package:resumenes/src/providers/carreras_provider.dart';
import 'package:resumenes/src/widgets/CTNoAvatar.dart';

class CarrerasPage extends StatefulWidget {
  // CarrerasPage({Key key, this.title}) : super(key: key);

  //Acá viene el nombre de la UNIVERSIDAD y la FACULTAD
  final Map<String, Object> arguments;

  CarrerasPage(this.arguments);

  @override
  _CarrerasPageState createState() => _CarrerasPageState();
}

class _CarrerasPageState extends State<CarrerasPage> {
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
        title: Text(widget.arguments['nombreFacultad']),
        actions: <Widget>[],
      ),
      body: _lista(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _lista() {
    print(widget.arguments);
    return FutureBuilder(
      future: carrerasProvider.cargarData(widget.arguments['nombreUniversidad'],
          widget.arguments['nombreFacultad']),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listaItems(snapshot.data),
          padding: EdgeInsets.symmetric(vertical: 20),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data) {
    final List<Widget> carreras = [];
    if (data != null) {
      data.forEach((c) {
        final widgetTemp = CustomTileNoAvatar('carreras',
            nombreUniversidad: widget.arguments['nombreUniversidad'],
            nombreFacultad: widget.arguments['nombreFacultad'],
            nombreCarrera: c['nombre']);
        carreras.add(widgetTemp);
        // carreras.add(Divider());
      });
    }

    return carreras;
  }
}
