import 'package:flutter/material.dart';
import 'package:resumenes/src/providers/downloads_provider.dart';

/*
//Clase dejada para modularizar después
*/

class DownloadCard extends StatefulWidget {
  dynamic file;

  DownloadCard(this.file);

  @override
  _DownloadCardState createState() => _DownloadCardState(file);
}

class _DownloadCardState extends State<DownloadCard> {
  final dynamic file;

  _DownloadCardState(this.file);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          downloadsProvider.deleteFile(file.path);
          // setState(() {
          //   Scaffold.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text("Archivo eliminado"),
          //     ),
          //   );
          // });
        },
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            downloadsProvider.openFile(file.path);
          },
          child: ListTile(
            leading: Icon(Icons.album),
            title: Text(file.path.substring(file.path.lastIndexOf("/") + 1)),
            subtitle: Text(file.parent.toString()),
          ),
        ),
      ),
    );
  }
}
