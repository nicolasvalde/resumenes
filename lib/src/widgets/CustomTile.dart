import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/components/list_tile/gf_list_tile.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/shape/gf_avatar_shape.dart';

class CustomTile extends StatelessWidget {
  String nombre;
  String imagen;

  CustomTile(String nombre, String imagen) {
    this.nombre = nombre;
    this.imagen = imagen;
  }

  @override
  Widget build(BuildContext context) {
    // return Material(
    //   color: (Colors.blue),
    //   child: InkWell(
    //     onTap: () {
    //       print('alaverga');
    //     },
    //     child: Container(
    //       padding: EdgeInsets.symmetric(horizontal: 20),
    //       child: GFListTile(
    //         titleText: nombre,
    //         icon: Icon(Icons.arrow_forward_ios),
    //         avatar: GFAvatar(
    //           backgroundImage: AssetImage('assets/' + imagen),
    //           shape: GFAvatarShape.square,
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    return Container(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: InkWell(
          onTap: () {
            print('la acción va acá');
          },
          splashColor: Colors.white,
          child: GFListTile(
            titleText: nombre,
            icon: Icon(Icons.arrow_forward_ios),
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
