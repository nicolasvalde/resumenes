import 'package:flutter/material.dart';
import 'package:resumenes/src/providers/resumenes_providers.dart';
import 'package:resumenes/src/widgets/ResumenCard.dart';

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
      body: Center(child: _lista()),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, 'upload');
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }

  Widget _lista() {
    Map<String, String> body = new Map();
    body['idMateria'] = widget.arguments['idMateria'].toString();
    // body['universidad'] = widget.arguments['nombreUniversidad'];
    // body['facultad'] = widget.arguments['nombreFacultad'];
    // body['carrera'] = widget.arguments['nombreCarrera'];
    // body['materia'] = widget.arguments['nombreMateria'];

    return FutureBuilder(
      future: resumenesProvider.getByParameters(body),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator(backgroundColor: Colors.grey);
        } else {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Text("Todavía no hay apuntes");
            } else {
              return ListView(
                children: _listaItems(snapshot.data),
                // padding: EdgeInsets.symmetric(vertical: 20),
              );
            }
          } else {
            return Container(
              child: Text('Hay un error en la red'),
            );
          }
        }
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data) {
    final List<Widget> resumenes = [];

    if (data != null) {
      data.forEach((r) {
        final cardTemp = new ResumenCard(r);
        resumenes.add(cardTemp);
      });
    }
    return resumenes;
  }
}
