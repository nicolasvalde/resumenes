import 'package:flutter/material.dart';
import 'package:resumenes/src/models/resumen_model.dart';

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
          },
          child: Container(
            width: 400,
            height: 100,
            child: Column(
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
                    Text('Fecha de subida: ${resumen.fechaSubida}')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
