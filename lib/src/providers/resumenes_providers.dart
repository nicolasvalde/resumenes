import 'dart:convert';
import 'dart:io';

import 'package:resumenes/src/models/resumen_model.dart';
import 'package:http/http.dart' as http;

class _ResumenesProvider {
  String _url = '10.0.2.2:8080';
  // String _url = '192.168.1.2:8080';

  _ResumenesProvider() {}

  Future<List<Resumen>> getAll() async {
    final url = Uri.http(_url, 'resumenes');

    final respuesta =
        await http.get(url, headers: {"Accept": "application/json"});

    String source = Utf8Decoder().convert(respuesta.bodyBytes);

    print(source);

    final decodedData = json.decode(source);

    final resumenes = new Resumenes.fromJsonList(decodedData);

    return resumenes.items;
  }

  Future<Resumen> getById(String id) async {
    final url = Uri.http(_url, 'resumenes/$id');

    final respuesta =
        await http.get(url, headers: {"Accept": "application/json"});

    String source = Utf8Decoder().convert(respuesta.bodyBytes);

    print(source);

    final decodedData = json.decode(source);

    final resumen = new Resumen.fromJsonMap(decodedData);

    return resumen;
  }

  Future save(Map<String, String> data, String file) async {
    final url = Uri.http(_url, 'resumenes');

    var body = json.encode(data);

    // final respuesta = await http.post(url,
    // headers: {"Content-Type": "multipart/form-data"}, body: body);
    // headers: {"Content-Type": "application/json"}, body: body);

    final respuesta = http.MultipartRequest('POST', url);

    respuesta.fields['resumen'] = body;

    respuesta.files.add(
      await http.MultipartFile.fromPath('file', file),
    );

    print(respuesta.files[0]);

    await respuesta.send();

    return respuesta;
  }

  update() {}

  delete() {}
}

final resumenesProvider = new _ResumenesProvider();
