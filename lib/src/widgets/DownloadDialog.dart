import 'package:flutter/material.dart';
import 'package:resumenes/src/models/resumen_model.dart';
import 'package:resumenes/src/providers/resumenes_providers.dart';

class DownloadDialog extends StatelessWidget {
  Resumen resumen;

  DownloadDialog(Resumen resumen) {
    this.resumen = resumen;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: <Widget>[
          Text("La info bonita con la opción de descarga va acá"),
          Text(resumen.descripcion),
          RaisedButton(
            child: Text("Descargar"),
            color: Colors.blue,
            textColor: Colors.white,
            splashColor: Colors.white,
            onPressed: () {
              resumenesProvider.download(resumen.id, resumen.fileName, context);
            },
          )
        ],
      ),
    );
  }
}
