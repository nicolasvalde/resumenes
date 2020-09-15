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
  int universidadId;
  int facultadId;
  int carreraId;
  int materiaId;
  String fechaSubida;
  String descripcion;
  String fileName;
  int yearCursado;

  Resumen(
      {this.id,
      this.autor,
      this.universidadId,
      this.facultadId,
      this.carreraId,
      this.materiaId,
      this.fechaSubida,
      this.descripcion,
      this.fileName,
      this.yearCursado});

  Resumen.fromJsonMap(Map<String, dynamic> json) {
    id            = json['id'];
    autor         = json['autor'];
    universidadId = json['universidadId'];
    facultadId    = json['facultadId'];
    carreraId     = json['carreraId'];
    materiaId     = json['materiaId'];
    fechaSubida   = json['fechaSubida'];
    descripcion   = json['descripcion'];
    fileName      = json['fileName'];
    yearCursado   = json['yearCursado'];
  }
}
