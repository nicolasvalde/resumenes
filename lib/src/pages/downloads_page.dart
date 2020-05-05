import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resumenes/src/providers/downloads_provider.dart';
import 'package:resumenes/src/widgets/DownloadCard.dart';

class DownloadsPage extends StatefulWidget {
  @override
  _DownloadsPageState createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<FileSystemEntity>>(
        future: downloadsProvider.list(),
        initialData: [],
        builder: (BuildContext context,
            AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          return Column(
            children: _listaItems(snapshot.data),
          );
        },
      ),
    );
  }

  List<Widget> _listaItems(List<FileSystemEntity> data) {
    final List<Widget> archivos = [];

    print(data.length);

    if (data != null) {
      data.forEach((file) {
        final cardTemp = new Card(
          child: Dismissible(
            background: Container(
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text("Eliminar"),
              ),
              color: Colors.redAccent,
            ),
            key: UniqueKey(),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              setState(() {
                data.remove(file);
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Archivo eliminado"),
                  ),
                );
                downloadsProvider.deleteFile(file.path);
              });
            },
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                downloadsProvider.openFile(file.path);
              },
              child: ListTile(
                leading: Icon(Icons.insert_drive_file),
                title:
                    Text(file.path.substring(file.path.lastIndexOf("/") + 1)),
                subtitle: Text(file.parent.toString()),
              ),
            ),
          ),
        );

        archivos.add(cardTemp);
      });
    }

    return archivos;
  }
}
