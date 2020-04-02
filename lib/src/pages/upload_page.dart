import 'package:flutter/material.dart';
import 'package:resumenes/src/providers/carreras_provider.dart';
import 'package:resumenes/src/providers/facultades_provider.dart';
import 'package:resumenes/src/providers/materias_provider.dart';
import 'package:resumenes/src/providers/menu_provider.dart';
import 'package:resumenes/src/providers/resumenes_providers.dart';

class UploadPage extends StatefulWidget {
  UploadPage(Object arguments);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String _selectedUniversidadValue;
  String _selectedFacultadValue;
  String _selectedCarreraValue;
  String _selectedMateriaValue;

  // List listUniversidades = ['Elegí una universidad'];
  // List listFacultades = ['Elegí una facultad'];
  // List listCarreras = ['Elegí una carrera'];
  // List listMaterias = ['Elegí una materia'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //     appBar: AppBar(
        //       title: Text('Subí tu resumen'),
        //     ),
        //     body:
        Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Builder(
        builder: (context) => Form(
          child: Column(
            children: <Widget>[
              _universidadesDropdown(),
              _facultadesDropdown(),
              _carrerasDropdown(),
              _materiasDropdown(),
              Center(
                child: RaisedButton(
                  onPressed: () {
                    Map<String, String> body = new Map();
                    body['autor'] = 'Nico';
                    body['descripcion'] = 'Resumen de teoría';
                    body['universidad'] = _selectedUniversidadValue;
                    body['facultad'] = _selectedFacultadValue;
                    body['carrera'] = _selectedCarreraValue;
                    body['materia'] = _selectedMateriaValue;
                    body['yearCursado'] = '2019';
                    resumenesProvider.save(body);
                  },
                  child: Text(
                    'Subir',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  splashColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // bottomNavigationBar: BottomNavigationBar(
    //   currentIndex: bottom,
    //   items: [
    //     BottomNavigationBarItem(
    //         icon: Icon(Icons.search), title: Text('Explorar resúmenes')),
    //     BottomNavigationBarItem(
    //         icon: Icon(Icons.add), title: Text('Subí tu resumen')),
    //   ],
    //   onTap: (bottom) {
    //     Navigator.pushNamed(context, 'home');
    //     setState(() {
    //       bottom = 1;
    //     });
    //   },
    // ));
  }

  Widget _universidadesDropdown() {
    return Center(
      child: FutureBuilder(
        initialData: [],
        future: menuProvider.cargarData(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return DropdownButton<dynamic>(
            isExpanded: true,
            hint: Text("Elegí una universidad"),
            items: snapshot.data
                .map((value) => DropdownMenuItem<dynamic>(
                      child: Text(value['nombre']),
                      value: value['nombre'],
                    ))
                .toList(),
            onChanged: (selectedValue) {
              setState(() {
                _selectedUniversidadValue = selectedValue;
                _selectedFacultadValue = null;
                _selectedCarreraValue = null;
                _selectedMateriaValue = null;
              });
            },
            value: _selectedUniversidadValue,
          );
        },
      ),
    );
  }

  Widget _facultadesDropdown() {
    if (_selectedUniversidadValue == null) {
      return Center(
        child: DropdownButton(
          isExpanded: true,
          hint: Text('Primero elegí una universidadad'),
        ),
      );
    } else {
      return Center(
        child: FutureBuilder(
          initialData: [],
          future: facultadesProvider.cargarData(_selectedUniversidadValue),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return DropdownButton<dynamic>(
              isExpanded: true,
              hint: Text("Elegí una facultad"),
              items: snapshot.data
                  .map((value) => DropdownMenuItem<dynamic>(
                        child: Text(value['nombre']),
                        value: value['nombre'],
                      ))
                  .toList(),
              onChanged: (selectedValue) {
                setState(() {
                  _selectedFacultadValue = selectedValue;
                  _selectedCarreraValue = null;
                  _selectedMateriaValue = null;
                });
              },
              value: _selectedFacultadValue,
            );
          },
        ),
      );
    }
  }

  Widget _carrerasDropdown() {
    if (_selectedUniversidadValue == null && _selectedFacultadValue == null) {
      return Center(
        child: DropdownButton(
          isExpanded: true,
          hint: Text('Primero elegí una universidadad'),
        ),
      );
    } else if (_selectedFacultadValue == null) {
      return Center(
        child: DropdownButton(
          isExpanded: true,
          hint: Text('Primero elegí una facultad'),
        ),
      );
    } else {
      return Center(
        child: FutureBuilder(
          initialData: [],
          future: carrerasProvider.cargarData(
              _selectedUniversidadValue, _selectedFacultadValue),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return DropdownButton<dynamic>(
              isExpanded: true,
              hint: Text("Elegí una carrera"),
              items: snapshot.data
                  .map((value) => DropdownMenuItem<dynamic>(
                        child: Text(value['nombre']),
                        value: value['nombre'],
                      ))
                  .toList(),
              onChanged: (selectedValue) {
                setState(() {
                  _selectedCarreraValue = selectedValue;

                  _selectedMateriaValue = null;
                });
              },
              value: _selectedCarreraValue,
            );
          },
        ),
      );
    }
  }

  Widget _materiasDropdown() {
    if (_selectedUniversidadValue == null) {
      return Center(
        child: DropdownButton(
          isExpanded: true,
          hint: Text('Primero elegí una universidadad'),
        ),
      );
    } else if (_selectedFacultadValue == null) {
      return Center(
        child: DropdownButton(
          isExpanded: true,
          hint: Text('Primero elegí una facultad'),
        ),
      );
    } else if (_selectedCarreraValue == null) {
      return Center(
        child: DropdownButton(
          isExpanded: true,
          hint: Text('Primero elegí una carrera'),
        ),
      );
    } else {
      return Center(
        child: FutureBuilder(
          initialData: [],
          future: materiasProvider.cargarData(_selectedUniversidadValue,
              _selectedFacultadValue, _selectedCarreraValue),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return DropdownButton<dynamic>(
              isExpanded: true,
              hint: Text("Elegí una materia"),
              items: snapshot.data
                  .map((value) => DropdownMenuItem<dynamic>(
                        child: Text(value['nombre']),
                        value: value['nombre'],
                      ))
                  .toList(),
              onChanged: (selectedValue) {
                setState(() {
                  _selectedMateriaValue = selectedValue;
                });
              },
              value: _selectedMateriaValue,
            );
          },
        ),
      );
    }
  }
}
