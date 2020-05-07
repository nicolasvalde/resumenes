import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resumenes/src/providers/downloads_provider.dart';

class DownloadsPage extends StatefulWidget {
  @override
  _DownloadsPageState createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Eliminá un archivo deslizándolo hacia la derecha"),
              duration: new Duration(milliseconds: 1500),
            ),
          )
        });
    return Container(
      child: FutureBuilder<List<FileSystemEntity>>(
        future: downloadsProvider.list(),
        initialData: [],
        builder: (BuildContext context,
            AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator(backgroundColor: Colors.grey);
          } else {
            return Column(
              children: _listaItems(snapshot.data),
            );
          }
        },
      ),
    );
  }

  List<Widget> _listaItems(List<FileSystemEntity> data) {
    final List<Widget> archivos = [];

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
                leading: Image.asset(
                  'assets/icons/' +
                      file.path.substring(file.path.lastIndexOf('.') + 1) +
                      '.png',
                  scale: 1.0,
                  height: 45.0,
                  width: 45.0,
                ),

                // CircleAvatar(
                //   backgroundColor: Colors.transparent,
                //   backgroundImage: AssetImage('assets/icons/' +
                //       file.path.substring(file.path.lastIndexOf('.') + 1) +
                //       '.png'),
                // ),
                title: Text(file.path.substring(file.path.lastIndexOf("/") + 1,
                    file.path.lastIndexOf('.'))),
                // subtitle: Text(file.parent.toString()),
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
