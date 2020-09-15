import 'dart:collection';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';

import 'db_provider.dart'; //probar a borrar despues

class _MateriasProvider {
  _MateriasProvider() {
    cargarData(null);
  }

  Future<List<dynamic>> cargarData(int idCarrera) async {
    try {

      Database db = await DBProvider.db.database;

      // var dbDir = await getDatabasesPath();
      // var dbPath = join(dbDir, "app.db");

      // final Database db = await openDatabase(dbPath);

      final List<Map<String, dynamic>> materias = await db.query('MATERIAS',
          where: 'carrera_fk = ?', whereArgs: [idCarrera.toString()]);

      print(materias);

      final List<Map<String, dynamic>> materiasClone = new List.from(materias);

      // await db.close();

      // final data = await rootBundle.loadString('data/universidades.json');
      // Map dataMapUniversidades = json.decode(data);
      // universidades = dataMapUniversidades['universidades'];

      // if (universidades != null) {
      //   universidades.forEach((u) {
      //     if (u['nombre'] == nombreUniversidad) {
      //       facultades = u['facultades'];
      //       facultades.forEach((f) {
      //         if (f['nombre'] == nombreFacultad) {
      //           carreras = f['carreras'];
      //           carreras.forEach((c) {
      //             if (c['nombre'] == nombreCarrera) {
      //               materias = c['materias'];
      //             }
      //           });
      //         }
      //       });
      //     }
      //   });
      // }

      // NO DESCOMENTAR ESTO DE ABAJO
      // final sorted = new SplayTreeMap.from(
      //     testMap,
      //     (a, b) => int.parse(testMap[a]['order'])
      //         .compareTo(int.parse(testMap[b]['order'])));

      if (materiasClone != null) {
        materiasClone.sort((m1, m2) => m1["nombre"].compareTo(m2["nombre"]));
      }

      return materiasClone;
    } catch (e) {
      print('PROBLEMA EN materias_provider');
      return [];
    }
  }
}

final materiasProvider = new _MateriasProvider();
