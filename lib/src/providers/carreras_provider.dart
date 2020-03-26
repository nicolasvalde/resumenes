import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:resumenes/src/providers/facultades_provider.dart';

class _CarrerasProvider {
  List<dynamic> universidades;
  List<dynamic> facultades;
  List<dynamic> carreras;

  _CarrerasProvider() {
    cargarData(null, null);
  }

  Future<List<dynamic>> cargarData(
      String nombreUniversidad, String nombreFacultad) async {
    final data = await rootBundle.loadString('data/universidades.json');
    Map dataMapUniversidades = json.decode(data);
    universidades = dataMapUniversidades['universidades'];
    if (universidades != null) {
      universidades.forEach((u) {
        if (u['nombre'] == nombreUniversidad) {
          facultades = u['facultades'];
          facultades.forEach((f) {
            if (f['nombre'] == nombreFacultad) {
              carreras = f['carreras'];
            }
          });
        }
      });
    }
    return carreras;
  }
}

final carrerasProvider = new _CarrerasProvider();
