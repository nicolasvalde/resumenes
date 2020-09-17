import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resumenes/src/models/resumen_model.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';

class _ResumenesProvider {
  //String _url = '10.0.2.2:8080';
  String _url = 'resumenes-sistemas-distribuido.herokuapp.com';
  // String _url = '10.0.2.2:5000';

  _ResumenesProvider() {}

  Future<List<Resumen>> getAll() async {
    final url = Uri.http(_url, 'resumenes');

    final respuesta =
        await http.get(url, headers: {"Accept": "application/json"});

    String source = Utf8Decoder().convert(respuesta.bodyBytes);

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

  Future<List<Resumen>> getByParameters(Map<String, String> data) async {
    final url = Uri.http(_url, "resumenes/list/${data['idMateria']}");
    // "resumenes/list/${data['universidad']}/${data['facultad']}/${data['carrera']}/${data['materia']}");

    print("URL: " + url.hasEmptyPath.toString());
    try {
      final respuesta =
          await http.get(url, headers: {"Accept": "application/json"});

      String source = Utf8Decoder().convert(respuesta.bodyBytes);

      final decodedData = json.decode(source);

      final resumenes = new Resumenes.fromJsonList(decodedData);

      return resumenes.items;
    } catch (e) {
      return null;
    }
  }

  Future save(Map<String, String> data, String file) async {
    final url = Uri.http(_url, 'resumenes');

    var body = json.encode(data);

    RegExp regExp = new RegExp(
      r"(.*?)\.(jpg|.jpeg|.png|doc|pdf|docx|rar|zip)$",
      caseSensitive: false,
      multiLine: false,
    );

    // Por el problema que al enviar .docx por whatsapp se borra la extension
    if ( !regExp.hasMatch(file.split("/").toString() ) ) {
      file = file + '.docx';
    }

    String resultado;

    final request = http.MultipartRequest('POST', url);

    request.fields['resumen'] = body;

    

    request.files.add(
      await http.MultipartFile.fromPath('file', file),
    );
    // try {
    await request.send().then((value) => {
          if (value.statusCode == 200)
            {resultado = "success"}
          else
            {
              throw ('Fijate que tengas conexión a la red y que el formato del archivo sea válido')
            }
        });

    print("REQUEST FIELDS ${request.fields}");

    return request;
  }

  update() {}

  delete() {}

  Future download(String id, String fileName, BuildContext context) async {
    Directory downloadsDir = await getExternalStorageDirectory();
    String downloadsPath = downloadsDir.path;

    final url = Uri.http(_url, 'resumenes/download/$id');

    print(downloadsPath);
    HttpClient client = new HttpClient();
    var _downloadData = List<int>();
    var fileSave = new File(downloadsPath + "/$fileName");

    await client.getUrl(url).then((HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) {
      response.listen((d) => _downloadData.addAll(d), onDone: () {
        fileSave.writeAsBytes(_downloadData);
        OpenFile.open(downloadsPath + "/$fileName");
        Navigator.pop(context);
      });
    });
  }
}

final resumenesProvider = new _ResumenesProvider();
