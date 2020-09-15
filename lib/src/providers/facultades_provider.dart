import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:path/path.dart';
import 'package:resumenes/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async'; //probar a borrar despues

class _FacultadesProvider {
  List<dynamic> facultades;

  _FacultadesProvider() {
    cargarData(null);
  }

  Future<List<dynamic>> cargarData(int idUniversidad) async {
    try {
      Database db = await DBProvider.db.database;
      // var dbDir = await getDatabasesPath();
      // var dbPath = join(dbDir, "app.db");

      // final Database db = await openDatabase(dbPath);

      final List<Map<String, dynamic>> facultades = await db.query('FACULTADES',
          where: 'universidad_fk = ?', whereArgs: [idUniversidad.toString()]);

      // print(facultades);

      // await db.close();

      // final data = await rootBundle.loadString('data/universidades.json');
      // Map dataMapUniversidades = json.decode(data);
      // universidades = dataMapUniversidades['universidades'];
      // if (universidades != null) {
      //   universidades.forEach((u) {
      //     if (u['nombre'] == nombreUniversidad) {
      //       facultades = u['facultades'];
      //     }
      //   });
      // }
      return facultades;
    } catch (e) {
      print('PROBLEMA EN facultades_provider');
      return [];
    }
  }
}

final facultadesProvider = new _FacultadesProvider();
