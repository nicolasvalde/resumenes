import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class _FacultadesProvider {
  List<dynamic> universidades;
  List<dynamic> facultades;

  _FacultadesProvider() {
    cargarData(null);
  }

  Future<List<dynamic>> cargarData(String nombreUniversidad) async {
    final data = await rootBundle.loadString('data/universidades.json');
    Map dataMapUniversidades = json.decode(data);
    universidades = dataMapUniversidades['universidades'];
    if (universidades != null) {
      universidades.forEach((u) {
        if (u['nombre'] == nombreUniversidad) {
          facultades = u['facultades'];
        }
      });
    }
    return facultades;
  }
}

final facultadesProvider = new _FacultadesProvider();
