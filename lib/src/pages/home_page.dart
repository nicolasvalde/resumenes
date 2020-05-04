import 'package:flutter/material.dart';
import 'package:resumenes/src/pages/upload_page.dart';
import 'package:resumenes/src/providers/menu_provider.dart';
import 'package:resumenes/src/widgets/CustomTile.dart';
import 'package:resumenes/src/widgets/listaUniversidades.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key key, this.title}) : super(key: key);

  String title = 'Universidades';

  String arguments;

  HomePage(arguments) {
    this.arguments = arguments;
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: _getSelectedScreen(),
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          currentIndex: _selectedBottomIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('Explorar resúmenes')),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), title: Text('Subí tu resumen')),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_download), title: Text('Descargas')),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedBottomIndex = index;
      if (_selectedBottomIndex == 0) {
        widget.title = 'Universidades';
      } else {
        widget.title = 'Subí tu resumen';
      }
      switch (_selectedBottomIndex) {
        case 0:
          widget.title = 'Universidades';
          break;
        case 1:
          widget.title = 'Subí tu resumen';
          break;
        case 2:
          widget.title = 'Resúmenes descargados';
          break;
      }
    });
  }

  Widget _getSelectedScreen() {
    switch (_selectedBottomIndex) {
      case 0:
        return Container(
          child: ListaUniversidadesWidget(),
        );
      case 1:
        return Container(
          alignment: Alignment.bottomCenter,
          child: UploadPage(null),
        );
      case 2:
        return Text(
            'Acá irían los resúmenes ya descargados con la opción de eliminar');
    }

    return ListaUniversidadesWidget();
  }
}
