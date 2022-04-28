import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';

class CustomTile extends StatelessWidget {
  int idUniversidad;
  String nombreUniversidad;
  String imagen;

  CustomTile(int idUniversidad, String nombreUniversidad, String imagen) {
    this.idUniversidad = idUniversidad;
    this.nombreUniversidad = nombreUniversidad;
    this.imagen = imagen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
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
            Navigator.pushNamed(context, 'facultades', arguments: {
              'idUniversidad': idUniversidad,
              'nombreUniversidad': nombreUniversidad
            });
          },
          splashColor: Colors.white,
          child: GFListTile(
            // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            titleText: nombreUniversidad,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            avatar: GFAvatar(
              backgroundImage: AssetImage('assets/' + imagen),
              shape: GFAvatarShape.square,
              size: GFSize.LARGE,
            ),
          ),
        ),
      ),
    );
  }
}
