import 'package:flutter/material.dart';
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

  Future<List<dynamic>> yearsList() async {
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
