import 'programa.dart';

class ProgramaNormal extends Programa {
  String? nombre;
  int? id;
  String? usuario;

  ProgramaNormal({this.nombre, this.id, this.usuario});

  @override
  String mostrar() {
    return "Programa de nombre $nombre\n";
  }

  @override
  void agregar(Programa n) {
    // Sin funcionalidad adicional
  }

  @override
  void quitar(Programa n) {
    // Sin funcionalidad adicional
  }

  @override
  Programa obtener(int i) {
    return this;
  }

  @override
  String ejecutar() {
    return "Ejecutando programa $nombre";
  }

  @override
  String detener() {
    return "Deteniendo programa $nombre";
  }

  @override
  String actualizar(String version, int tamActu) {
    return 'Programa normal no se actualiza';
  }

  @override
  Programa duplicar() {
    // Devuelve el mismo id. No deberia. Haz algo.
    Programa copia = ProgramaNormal(nombre: nombre, id: id);
    return copia;
  }

  @override
  void duplicar_programa(int i) {
    // Sin funcionalidad adicional
  }

  @override
  bool sonIguales(Programa p) {
    if (p is ProgramaNormal) {
      ProgramaNormal pn = p as ProgramaNormal;
      return this.nombre == pn.nombre;
    }
    return false;
  }

  factory ProgramaNormal.fromJson(Map<String, dynamic> json) {
    return ProgramaNormal(
        nombre: json['nombre'] as String?,
        id: json['id'] as int?,
        usuario: json['usuario']);
  }

  Map<String, dynamic> toJson() {
    return {if (id != null) 'id': id, 'nombre': nombre, 'usuario': usuario};
  }
}
