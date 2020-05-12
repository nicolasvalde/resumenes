import 'package:flutter/material.dart';
import 'package:resumenes/src/providers/facultades_provider.dart';
import 'package:resumenes/src/widgets/CTNoAvatar.dart';

class FacultadesPage extends StatefulWidget {
  // FacultadesPage({Key key, this.title}) : super(key: key);

  //Acá viene el nombre de la UNIVERSIDAD
  final Map<String, Object> arguments;

  FacultadesPage(this.arguments);

  @override
  _FacultadesPageState createState() => _FacultadesPageState();
}

class _FacultadesPageState extends State<FacultadesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.arguments['nombreUniversidad']),
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
    print(widget.arguments);

    return FutureBuilder(
      // Busca las facultades de acuerdo a argument (nombre de la universidad)
      future:
          facultadesProvider.cargarData(widget.arguments['nombreUniversidad']),
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
    final List<Widget> facultades = [];
    if (data != null) {
      data.forEach((f) {
        final widgetTemp = CustomTileNoAvatar('facultades',
            nombreUniversidad: widget.arguments['nombreUniversidad'],
            nombreFacultad: f['nombre']);
        facultades.add(widgetTemp);
      });
    }

    return facultades;
  }
}
