import 'package:flutter/material.dart';
import 'package:resumenes/src/pages/carreras_page.dart';
import 'package:resumenes/src/pages/facultades_page.dart';
import 'package:resumenes/src/pages/home_page.dart';
import 'package:resumenes/src/pages/materias_page.dart';
import 'package:resumenes/src/pages/resumenes_page.dart';
import 'package:resumenes/src/pages/upload_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Resúmenes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: FacultadesPage(title: 'Resúmenes'),
      initialRoute: '/',
      // routes: <String, WidgetBuilder>{
      //   '/': (BuildContext context) => HomePage(),
      //   'facultades': (BuildContext context) => FacultadesPage(),
      //   'carreras': (BuildContext context) => CarrerasPage(),
      //   'materias': (BuildContext context) => MateriasPage(),
      // },
      onGenerateRoute: (RouteSettings settings) {
        print('build route for ${settings.name}');
        var routes = <String, WidgetBuilder>{
          '/': (BuildContext context) => HomePage(settings.arguments),
          'facultades': (BuildContext context) =>
              FacultadesPage(settings.arguments),
          'carreras': (BuildContext context) =>
              CarrerasPage(settings.arguments),
          'materias': (BuildContext context) =>
              MateriasPage(settings.arguments),
          'resumenes': (BuildContext context) =>
              ResumenesPage(settings.arguments),
          'upload': (BuildContext context) => UploadPage(settings.arguments)
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
