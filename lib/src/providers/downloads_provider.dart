import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class _DownloadsProvider {
  Future<List<FileSystemEntity>> list() async {
    Directory downloadsDir = await getExternalStorageDirectory();

    return downloadsDir.listSync().toList();

    //   await client.getUrl(url).then((HttpClientRequest request) {
    //     return request.close();
    //   }).then((HttpClientResponse response) {
    //     response.listen((d) => _downloadData.addAll(d), onDone: () {
    //       fileSave.writeAsBytes(_downloadData);
    //       OpenFile.open(downloadsPath + "/$fileName");
    //       Navigator.pop(context);
    //     });
    //   });
  }

  void openFile(String path) {
    OpenFile.open(path);
  }

  void deleteFile(String path) async {
    File tempFile = File(path);
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
  }
}

final downloadsProvider = new _DownloadsProvider();
