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
          Text("La info del resumen con la opción de descarga va acá"),
          Text(resumen.descripcion),
          RaisedButton(
            child: Text("Descargar"),
            color: Colors.blue,
            textColor: Colors.white,
            splashColor: Colors.white,
            onPressed: () async {
             // Navigator.pop(context);
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return WillPopScope(
                      onWillPop: () async => false,
                      child: AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Text("Descargando archivo..."),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
              await resumenesProvider.download(resumen.id, resumen.fileName, context);
              Future.sync(() => Navigator.pop(context));
            },
          )
        ],
      ),
    );
  }
}
