import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async'; //probar a borrar despues

class CustomTileNoAvatar extends StatelessWidget {
  int universidadId;
  String nombreUniversidad;
  int idFacultad;
  String nombreFacultad;
  int idCarrera;
  String nombreCarrera;
  int idMateria;
  String nombreMateria;
  String origen;
  String nombreMostrar;

  CustomTileNoAvatar(String origen,
      {String nombreUniversidad,
      int idFacultad,
      String nombreFacultad,
      int idCarrera,
      String nombreCarrera,
      int idMateria,
      String nombreMateria}) {
    this.nombreUniversidad = nombreUniversidad;
    this.idFacultad = idFacultad;
    this.nombreFacultad = nombreFacultad;
    this.idCarrera = idCarrera;
    this.nombreCarrera = nombreCarrera;
    this.idMateria = idMateria;
    this.nombreMateria = nombreMateria;
    this.origen = origen;
  }

  @override
  Widget build(BuildContext context) {
    switch (origen) {
      case 'facultades':
        {
          nombreMostrar = nombreFacultad;
        }
        break;
      case 'carreras':
        {
          nombreMostrar = nombreCarrera;
        }
        break;
      case 'materias':
        {
          nombreMostrar = nombreMateria;
        }
        break;
      default:
    }
    return Container(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2.0, 2.0), //(x,y)
              blurRadius: 3.0,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            switch (origen) {
              case 'facultades':
                {
                  Navigator.pushNamed(context, 'carreras', arguments: {
                    'idFacultad': idFacultad,
                    'nombreFacultad': nombreFacultad
                  });
                }
                break;
              case 'carreras':
                {
                  Navigator.pushNamed(context, 'materias', arguments: {
                    'idCarrera': idCarrera,
                    'nombreCarrera': nombreCarrera
                  });
                }
                break;
              case 'materias':
                {
                  Navigator.pushNamed(context, 'resumenes', arguments: {
                    'idMateria': idMateria,
                    'nombreMateria': nombreMateria
                  });
                }
            }
          },
          splashColor: Colors.white,
          child: GFListTile(
            titleText: nombreMostrar,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            // avatar: GFAvatar(
            //   backgroundImage: AssetImage('assets/' + imagen),
            //   shape: GFAvatarShape.square,
            //   size: GFSize.LARGE,
            // ),
          ),
        ),
      ),
    );
  }
}

_getData(String origen, int param) async {
  var dbDir = await getDatabasesPath();
  var dbPath = join(dbDir, "app.db");

  final Database db = await openDatabase(dbPath);

  final List<Map<String, dynamic>> data = await db.query(origen.toUpperCase(),
      where: origen.substring(0, 1) + '_fk = ?', whereArgs: [param.toString()]);

  print(data);

  if (origen.compareTo('materias') == 0) {
    final List<Map<String, dynamic>> materiasClone = new List.from(data);
    await db.close();
    return materiasClone;
  }
  await db.close();

  return data;
}
