import 'dart:io';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async'; //probar a borrar despues

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
    }
     
  }

  initDB() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "app.db");

    ByteData data = await rootBundle.load("data/databases/universidades.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);

    return await openDatabase(dbPath, version: 1, onOpen: (db) {});
  }
}
