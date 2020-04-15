import 'package:flutter/material.dart';
import 'package:resumenes/src/providers/menu_provider.dart';

import 'CustomTile.dart';

class ListaUniversidadesWidget extends StatefulWidget {
  @override
  _ListaUniversidadesWidgetState createState() =>
      _ListaUniversidadesWidgetState();
}

class _ListaUniversidadesWidgetState extends State<ListaUniversidadesWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: menuProvider.cargarData(),
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
    final List<Widget> universidades = [];

    data.forEach((u) {
      final widgetTemp = CustomTile(u['nombre'], u['imagen']);
      universidades.add(widgetTemp);
      // universidades.add(Divider());
    });

    return universidades;
  }
}