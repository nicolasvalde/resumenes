import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:resumenes/src/providers/facultades_provider.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';

import 'db_provider.dart'; //probar a borrar despues

class _CarrerasProvider {
  _CarrerasProvider() {
    cargarData(null);
  }

  Future<List<dynamic>> cargarData(int idFacultad) async {
    try {

      Database db = await DBProvider.db.database;
      
      // print(idFacultad);
      // var dbDir = await getDatabasesPath();
      // var dbPath = join(dbDir, "app.db");

      // final Database db = await openDatabase(dbPath);

      final List<Map<String, dynamic>> carreras = await db.query('CARRERAS',
          where: 'facultad_fk = ?', whereArgs: [idFacultad.toString()]);

      print(carreras);

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
      //         }
      //       });
      //     }
      //   });
      // }
      return carreras;
    } catch (e) {
      print('PROBLEMA EN carerras_provider');
      return [];
    }
  }
}

final carrerasProvider = new _CarrerasProvider();
