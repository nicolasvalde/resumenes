class Resumenes {
  List<Resumen> items = new List();

  Resumenes();

  Resumenes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final resumen = new Resumen.fromJsonMap(item);
      items.add(resumen);
    }
  }
}

class Resumen {
  String id;
  String autor;
  String universidad;
  String facultad;
  String carrera;
  String materia;
  String fechaSubida;
  String descripcion;
  int yearCursado;

  Resumen(
      {this.id,
      this.autor,
      this.universidad,
      this.facultad,
      this.carrera,
      this.materia,
      this.fechaSubida,
      this.descripcion,
      this.yearCursado});

  Resumen.fromJsonMap(Map<String, dynamic> json) {
    id          = json['id'];
    autor       = json['autor'];
    universidad = json['universidad'];
    facultad    = json['facultad'];
    carrera     = json['carrera'];
    materia     = json['materia'];
    fechaSubida = json['fechaSubida'];
    descripcion = json['descripcion'];
    yearCursado = json['yearCursado'];
  }
}
