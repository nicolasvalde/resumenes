import 'dart:convert';

import 'package:resumenes/src/models/resumen_model.dart';
import 'package:http/http.dart' as http;

class ResumenesProvider {
  String _url = '10.0.2.2:8080';

  Future<List<Resumen>> getAll() async {
    final url = Uri.http(_url, 'resumenes');

    final respuesta =
        await http.get(url, headers: {"Accept": "application/json"});

    final decodedData = json.decode(respuesta.body);

    final resumenes = new Resumenes.fromJsonList(decodedData);

    return resumenes.items;
  }

  Future<Resumen> getById(String id) async {
    final url = Uri.http(_url, 'resumenes/$id');

    final respuesta =
        await http.get(url, headers: {"Accept": "application/json"});

    final decodedData = json.decode(respuesta.body);

    final resumen = new Resumen.fromJsonMap(decodedData);

    return resumen;
  }

  Future save() async {
    final url = Uri.http(_url, 'resumenes');

    // final respuesta = await http.post(url, headers: {"Accept": "application/json"}, body null, encoding null);
  }

  update() {}

  delete() {}
}
