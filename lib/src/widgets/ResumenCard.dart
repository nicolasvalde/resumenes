import 'package:flutter/material.dart';
import 'package:resumenes/src/models/resumen_model.dart';
import 'package:resumenes/src/widgets/DownloadDialog.dart';

class ResumenCard extends StatelessWidget {
  final Resumen resumen;

  ResumenCard(this.resumen);

  @override
  Widget build(BuildContext context) {
    print(resumen);

    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
            showDialog(
              context: context,
              child: DownloadDialog(resumen),
            );
          },
          child: Container(
            width: 400,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Descripción: ${resumen.descripcion}')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Autor: ${resumen.autor} '),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Año de cursado: ${resumen.yearCursado}')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Fecha de subida: ${resumen.fechaSubida.toString()}')
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
