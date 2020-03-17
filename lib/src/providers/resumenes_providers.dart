import 'dart:convert';

import 'package:resumenes/src/models/resumen_model.dart';
import 'package:http/http.dart' as http;

class ResumenesProvider {
  String _url = '10.0.2.2:8080';

  Future<List<Resumen>> getAll() async {
    final url = Uri.http(_url, 'resumenes');

    final respuesta = await http.get(url, headers: {"Accept": "application/json"});

    final decodedData = json.decode(respuesta.body);

    print(decodedData);

    return [];
  }
}
