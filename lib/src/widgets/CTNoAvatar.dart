import 'package:flutter/material.dart';
import 'package:getflutter/components/list_tile/gf_list_tile.dart';
import 'package:getflutter/getflutter.dart';

class CustomTileNoAvatar extends StatelessWidget {
  String nombreUniversidad;
  String nombreFacultad;
  String nombreCarrera;
  String nombreMateria;
  String origen;
  String nombreMostrar;

  CustomTileNoAvatar(String origen,
      {String nombreUniversidad,
      String nombreFacultad,
      String nombreCarrera,
      String nombreMateria}) {
    this.nombreUniversidad = nombreUniversidad;
    this.nombreFacultad = nombreFacultad;
    this.nombreCarrera = nombreCarrera;
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
                    'nombreUniversidad': nombreUniversidad,
                    'nombreFacultad': nombreFacultad
                  });
                }
                break;
              case 'carreras':
                {
                  Navigator.pushNamed(context, 'materias', arguments: {
                    'nombreUniversidad': nombreUniversidad,
                    'nombreFacultad': nombreFacultad,
                    'nombreCarrera': nombreCarrera
                  });
                }
                break;
              case 'materias':
                {
                  Navigator.pushNamed(context, 'resumenes', arguments: {
                    'nombreUniversidad': nombreUniversidad,
                    'nombreFacultad': nombreFacultad,
                    'nombreCarrera': nombreCarrera,
                    'nombreMateria': nombreMateria
                  });
                }
            }
          },
          splashColor: Colors.white,
          child: GFListTile(
            titleText: nombreMostrar,
            icon: Icon(Icons.arrow_forward_ios),
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
