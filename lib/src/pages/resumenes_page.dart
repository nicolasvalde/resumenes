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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'upload');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: resumenesProvider.getAll(),
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
    final List<Widget> resumenes = [];
    for (var i = 0; i < 10; i++) {
      if (data != null) {
        data.forEach((r) {
          final cardTemp = new ResumenCard(r);
          resumenes.add(cardTemp);
        });
      }
    }
    return resumenes;
  }
}
