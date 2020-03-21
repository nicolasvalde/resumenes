import 'package:flutter/material.dart';
import 'package:resumenes/src/providers/menu_provider.dart';
import 'package:resumenes/src/providers/resumenes_providers.dart';
import 'package:getflutter/getflutter.dart';
import 'package:resumenes/src/widgets/CustomTile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // showSearch(
              // context: context,
              // delegate: CustomSearchDelegate(),
              // );
              menuProvider.cargarData().then((universidades) {
                print(universidades);
              });
              // ResumenesProvider resumenesProvider = new ResumenesProvider();
              // resumenesProvider.getById('5e6b93240dab7e1efe10424a');
            },
          )
        ],
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
