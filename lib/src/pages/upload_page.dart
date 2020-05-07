import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resumenes/src/providers/carreras_provider.dart';
import 'package:resumenes/src/providers/facultades_provider.dart';
import 'package:resumenes/src/providers/materias_provider.dart';
import 'package:resumenes/src/providers/menu_provider.dart';
import 'package:resumenes/src/providers/resumenes_providers.dart';

import 'package:file_picker/file_picker.dart';

class UploadPage extends StatefulWidget {
  UploadPage(Object arguments);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String _autor;
  String _descripcion;
  String _selectedUniversidadValue;
  String _selectedFacultadValue;
  String _selectedCarreraValue;
  String _selectedMateriaValue;
  String _yearCursado;

  String _filePath;

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
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: Builder(
          builder: (context) => Form(
            child: Column(
              children: <Widget>[
                _autorTextField(),
                _descripcionTextField(),
                _yearCursadoDropdown(),
                _universidadesDropdown(),
                _facultadesDropdown(),
                _carrerasDropdown(),
                _materiasDropdown(),
                _fileSection(),
                _uploadButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _autorTextField() {
    return Center(
      child: TextField(
        decoration: InputDecoration(labelText: 'Tu nombre o apodo'),
        onChanged: (valor) {
          setState(() {
            _autor = valor;
          });
        },
      ),
    );
  }

  Widget _descripcionTextField() {
    return Center(
      child: TextField(
        minLines: 1,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: 'Descripción de lo que estás subiendo',
        ),
        onChanged: (valor) {
          setState(() {
            _descripcion = valor;
          });
        },
      ),
    );
  }

  Widget _yearCursadoDropdown() {
    return FutureBuilder<List<DropdownMenuItem>>(
      initialData: [],
      future: menuProvider.yearsList(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return DropdownButton<dynamic>(
          items: snapshot.data,
          onChanged: (yearValue) {
            setState(() {
              _yearCursado = yearValue.toString();
            });
          },
          isExpanded: true,
          hint: Text("Año en que cursaste la materia"),
          value: _yearCursado,
        );
      },
    );
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
      return Container();
      // return Center(
      //   child: DropdownButton(
      //     isExpanded: true,
      //     hint: Text('Primero elegí una universidadad'),
      //   ),
      // );
    } else {
      return Center(
        child: FutureBuilder(
          initialData: [],
          future: facultadesProvider.cargarData(_selectedUniversidadValue),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) return Container();
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
      return Container();
      // return Center(
      //   child: DropdownButton(
      //     isExpanded: true,
      //     hint: Text('Primero elegí una universidadad'),
      //   ),
      // );
    } else if (_selectedFacultadValue == null) {
      return Container();
      // return Center(
      //   child: DropdownButton(
      //     isExpanded: true,
      //     hint: Text('Primero elegí una facultad'),
      //   ),
      // );
    } else {
      return Center(
        child: FutureBuilder(
          initialData: [],
          future: carrerasProvider.cargarData(
              _selectedUniversidadValue, _selectedFacultadValue),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) return Container();
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
      return Container();
      // return Center(
      //   child: DropdownButton(
      //     isExpanded: true,
      //     hint: Text('Primero elegí una universidadad'),
      //   ),
      // );
    } else if (_selectedFacultadValue == null) {
      return Container();
      // return Center(
      //   child: DropdownButton(
      //     isExpanded: true,
      //     hint: Text('Primero elegí una facultad'),
      //   ),
      // );
    } else if (_selectedCarreraValue == null) {
      return Container();
      // return Center(
      //   child: DropdownButton(
      //     isExpanded: true,
      //     hint: Text('Primero elegí una carrera'),
      //   ),
      // );
    } else {
      return Center(
        child: FutureBuilder(
          initialData: [],
          future: materiasProvider.cargarData(_selectedUniversidadValue,
              _selectedFacultadValue, _selectedCarreraValue),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) return Container();
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

  Widget _fileSection() {
    if (_selectedMateriaValue == null) {
      return Container();
    } else if (_filePath == null) {
      return Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text('Seleccionar archivo',
                  style: TextStyle(color: Colors.white)),
              onPressed: () async {
                var path = await FilePicker.getFilePath(type: FileType.any);
                setState(() {
                  _filePath = path;
                });
              },
              color: Colors.blue,
              splashColor: Colors.white,
            ),
          ),
          Center(
            child: Text("Tamaño máximo: 50 MB"),
          ),
        ],
      );
    } else if (_filePath != null) {
      return Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.attach_file),
                title: Text(_filePath.split("/").last),
                // subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
              ButtonBar(
                children: <Widget>[
                  // FlatButton(
                  //   child: const Text('BUY TICKETS'),
                  //   onPressed: () {/* ... */},
                  // ),
                  FlatButton(
                    child: const Text('Eliminar'),
                    onPressed: () {
                      setState(() {
                        _filePath = null;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _uploadButton() {
    if (_filePath == null || _autor == null || _descripcion == null) {
      return Container();
    } else {
      return Center(
        child: RaisedButton(
          onPressed: () async {
            Map<String, String> body = new Map();
            body['autor'] = _autor;
            body['descripcion'] = _descripcion;
            body['universidad'] = _selectedUniversidadValue;
            body['facultad'] = _selectedFacultadValue;
            body['carrera'] = _selectedCarreraValue;
            body['materia'] = _selectedMateriaValue;
            body['yearCursado'] = _yearCursado;
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircularProgressIndicator(
                            backgroundColor: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Text("Subiendo archivo."),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            );

            await resumenesProvider.save(body, _filePath);

            Future.sync(() => Navigator.pop(context));

            showDialog(
                context: context,
                child: AlertDialog(
                  content: Text("Resumen guardado con éxito"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Aceptar"))
                  ],
                ));
            _alerta();
            setState(() {
              _autor = "";
              _descripcion = "";
              _selectedUniversidadValue = null;
              _selectedFacultadValue = null;
              _selectedCarreraValue = null;
              _selectedMateriaValue = null;
              _yearCursado = null;
              _filePath = null;
            });
          },
          child: Text(
            'Subir',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
          splashColor: Colors.white,
        ),
      );
    }
  }

  Widget _alerta() {
    return AlertDialog(
      title: Text("Resumen guardado con éxito"),
    );
  }
}
