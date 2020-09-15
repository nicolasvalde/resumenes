import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async'; //probar a borrar despues
import 'db_provider.dart';

class _MenuProvider {

  List<dynamic> universidades;

  _MenuProvider() {
    cargarData();
  }

  Future<List<dynamic>> cargarData() async {
    // database = openDatabase(
    //   join(await getDatabasesPath(), 'universidades.db'),
    // );

    Database db = await DBProvider.db.database;

    try {
      // var dbDir = await getDatabasesPath();
      // var dbPath = join(dbDir, "app.db");

      // ByteData data = await rootBundle.load("data/databases/universidades.db");
      // List<int> bytes =
      //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // await File(dbPath).writeAsBytes(bytes);

      // final Database db = await openDatabase(dbPath, readOnly: true);

      final List<Map<String, dynamic>> universidades =
          await db.query('UNIVERSIDADES');

      print(universidades);

      // await db.close();

      // final data = await rootBundle.loadString('data/universidades.json');
      // Map dataMap = json.decode(data);
      // universidades = dataMap['universidades'];

      return universidades;
    } catch (e) {
      print('PROBLEMA EN menu_provider ${e}');
      return [];
    }
  }

  Future<List<DropdownMenuItem>> yearsList() async {
    List<DropdownMenuItem> years = new List();

    var date = new DateTime.now();

    var year = 2015;

    int actualYear = date.year;

    do {
      var temp = new DropdownMenuItem(
        child: Text(year.toString()),
        value: year.toString(),
      );
      await years.add(temp);
      await year++;
    } while (year <= actualYear);

    return years;
  }
}

final menuProvider = new _MenuProvider();
