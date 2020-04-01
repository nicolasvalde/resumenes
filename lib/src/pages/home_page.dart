import 'package:flutter/material.dart';
import 'package:resumenes/src/pages/upload_page.dart';
import 'package:resumenes/src/providers/menu_provider.dart';
import 'package:resumenes/src/widgets/CustomTile.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key key, this.title}) : super(key: key);

  String arguments;

  HomePage(arguments) {
    this.arguments = arguments;
  }

  final String title = 'Universidades';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  int _selectedBottomIndex = 0;

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
        actions: <Widget>[],
      ),
      body: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: _lista(),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: UploadPage(null),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('Explorar resúmenes')),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), title: Text('Subí tu resumen')),
        ],
        onTap: _onItemTapped,
      ),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedBottomIndex = index;
    });
  }
}
