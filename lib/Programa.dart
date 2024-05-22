import 'dart:convert'; // Importa para el manejo de JSON
import 'package:ejgrupal/ProgramaNormal.dart'; // Asegúrate de que este archivo y la clase existan y estén definidos correctamente.

class Programa {
  List<Programa> hijos = [];
  int id = 0;
  String usuario = "";

  Programa();

  String mostrar() {
    return "";
  }

  void agregar(Programa n) {}

  void quitar(Programa n) {}

  Programa obtener(int i) {
    return hijos[i];
  }

  String ejecutar() {
    return "";
  }

  String detener() {
    return "";
  }

  Programa duplicar() {
    return Programa();
  }

  String actualizar(String version, int tamActu) {
    return "";
  }

  void duplicar_programa(int i) {}

  bool sonIguales(Programa p) {
    return false;
  }

  // Implementación de fromJson y toJson
  factory Programa.fromJson(Map<String, dynamic> json) {
    return Programa();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    return data;
  }
}
