import 'dart:collection';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class _MateriasProvider {
  List<dynamic> universidades;
  List<dynamic> facultades;
  List<dynamic> carreras;
  List<dynamic> materias;

  _MateriasProvider() {
    cargarData(null, null, null);
  }

  Future<List<dynamic>> cargarData(String nombreUniversidad,
      String nombreFacultad, String nombreCarrera) async {
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
              carreras.forEach((c) {
                if (c['nombre'] == nombreCarrera) {
                  materias = c['materias'];
                }
              });
            }
          });
        }
      });
    }
    // final sorted = new SplayTreeMap.from(
    //     testMap,
    //     (a, b) => int.parse(testMap[a]['order'])
    //         .compareTo(int.parse(testMap[b]['order'])));

    if (materias != null) {
      materias.sort((m1, m2) => m1["nombre"].compareTo(m2["nombre"]));
    }

    return materias;
  }
}

final materiasProvider = new _MateriasProvider();
