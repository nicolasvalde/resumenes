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
  String universidad;
  String carrera;
  String materia;
  List<dynamic> profesores;
  String unidades;

  Resumen({
    this.id,
    this.universidad,
    this.carrera,
    this.materia,
    this.profesores,
    this.unidades,
  });

  Resumen.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    universidad = json['universidad'];
    carrera = json['carrera'];
    materia = json['materia'];
    profesores = json['profesores'];
    unidades = json['unidades'];
  }
}

class Profesor {
  String algo;

  Profesor({
    this.algo,
  });
}
