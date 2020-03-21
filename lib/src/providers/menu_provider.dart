import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class _MenuProvider {
  List<dynamic> universidades;

  _MenuProvider() {
    cargarData();
  }

  Future<List<dynamic>> cargarData() async {
    final data = await rootBundle.loadString('data/universidades.json');
    Map dataMap = json.decode(data);
    universidades = dataMap['universidades'];
    return universidades;
  }
}

final menuProvider = new _MenuProvider();
