import 'dart:convert';
// import 'dart:html';
import 'dart:typed_data';
import 'dart:io';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:xml/xml.dart';
// import 'package:xml_parser/xml_parser.dart';

class MimeType {
  static Future getMimeType(Uint8List bytes, String uriString) async {
    var hexBytes = hex.encode(bytes);
    String mime = await _compareMagicNumbers(hexBytes, uriString);
    return mime;
  }

  static Future<String> _compareMagicNumbers(String hexBytes, String uriString) async {
    for (var key in _DEFAULT_MAGIC_NUMBERS.keys) {
      // print(hexBytes);
      if (hexBytes.substring(0, key.length).compareTo(key) == 0) {
        print('LO ENCONTRO!!!!!!!!');
        if (key.compareTo('504b030414000600') == 0) {
          String mime = await _getOfficeMimeType(hex.decode(hexBytes), uriString);
          return mime;
          // break;
          // return 0;
        } else {
          return _DEFAULT_MAGIC_NUMBERS[key];
        }
      } else {
        print('NO LO ENCONTRO :(');
      }
    }

    return null;
  }

  static Future _getOfficeMimeType(List<int> bytes, String uriString) async {
    final bytes = new File(uriString).readAsBytesSync();
    final archive = new ZipDecoder().decodeBytes(bytes);

    Directory downloadsDir = await getTemporaryDirectory();
    String downloadsPath = '${downloadsDir.path}';

    for (var file in archive) {
      final filename = '$downloadsPath/temp.xml';
      if (file.isFile) {
        if (file.name.compareTo('[Content_Types].xml') == 0) {
          final decompressed = await compute(_decompressArchiveFile, file);
          File outFile = new File('$filename');
          outFile = await outFile.create(recursive: true);
          await outFile.writeAsBytes(decompressed);
          XmlDocument xmlDocument =
              XmlDocument.parse(outFile.readAsStringSync());
          print(xmlDocument.toXmlString());

          String xmlString = xmlDocument.toXmlString();

          for (String x in _OFFICE_MIME_TYPE) {
            print('LA ITERACION: $x');
            if (xmlString.contains(x)) {
              print('hay coincidencia');
              return x;
            }
          }

          break;
        }
      } else {
        await new Directory(filename).create(recursive: true);
      }
    }
  }

  static List<int> _decompressArchiveFile(ArchiveFile file) {
    return file.content;
  }

  static const Map<String, String> _DEFAULT_MAGIC_NUMBERS = {
    '504b030414000600': 'office',
    '25504446': 'application/pdf',
    'FFD8': 'image/jpeg',
    '89504E470D0A1A0A': 'image/png'
  };

  static const Set<String> _OFFICE_MIME_TYPE = {
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  };
}
