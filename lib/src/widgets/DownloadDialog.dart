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
      contentPadding: EdgeInsets.only(bottom: 0, top: 8, left: 8, right: 8),
      actions: <Widget>[
        RaisedButton(
          child: Text("Descargar"),
          color: Colors.blue,
          textColor: Colors.white,
          splashColor: Colors.white,
          onPressed: () async {
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
            await resumenesProvider.download(
                resumen.id, resumen.fileName, context);
            Future.sync(() => Navigator.pop(context));
          },
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
          // color: Colors.black,
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          Image.asset(
            'assets/icons/' +
                resumen.fileName
                    .substring(resumen.fileName.lastIndexOf('.') + 1) +
                '.png',
            scale: 1.0,
            height: 60.0,
            width: 60.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Text(
            "Vas a descargar el archivo: " + resumen.fileName,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
        ],
      ),
    );
  }
}
