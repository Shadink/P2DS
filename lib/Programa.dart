class Programa {
  List<Programa> hijos = [];
  String? nombre = "";
  int? id = 0;
  String? usuario = "";
  String? so = "";
  String? version = "";
  int? size = 0;  

  Programa({this.nombre, this.id, this.usuario, this.so, this.version, this.size}){}
  String mostrar(){return "";}
  void agregar(Programa n){}
  void quitar(Programa n){}
  Programa obtener(int i){return Programa();}
  String ejecutar(){return "";}
  String detener(){return "";}
  Programa duplicar(){return Programa();}
  String actualizar(String version, int tamActu){return "";}
  void duplicar_programa(int i){}
  bool sonIguales(Programa p){return false;}
  
  factory Programa.fromJson(Map<String, dynamic> json) {
    return Programa(
        nombre: json['nombre'] as String?,
        id: json['id'] as int?,
        usuario: json['usuario'],
        so: json['so'],
        version: json['version'],
        size: json['size']);
  }  

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nombre': nombre,
      'usuario': usuario,
      'so' : so,
      'version' : version,
      'size' : size
    };
  }  
}
