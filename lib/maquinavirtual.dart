import 'dart:io';

import 'programa.dart';
import 'ProgramaNormal.dart';

class MaquinaVirtual extends Programa {
  String so = "";
  String version = "";
  int size = 0;

  @override
  String mostrar() {
    return "Máquina virtual $so $version $size GB libres\n";
  }

  @override
  void agregar(Programa n) {
    hijos.add(n);
  }

  @override
  void quitar(Programa n) {
    hijos.remove(n);
  }

  @override
  Programa obtener(int i) {
    if (i < 0)
      return hijos[0];
    else if (i < hijos.length)
      return hijos[i];
    else {
      return hijos[hijos.length - 1];
    }
  }

  @override
  String ejecutar() {
    return "Ejecutando máquina virtual $so $version";
  }

  @override
  String detener() {
    return "Deteniendo máquina virtual $so $version";
  }

  @override
  String actualizar(String version, int tamActu) {
    if (this.size - tamActu < 0) {
      return "No hay suficiente espacio en la máquina virtual para la actualización";
    }
    else {
      this.version = version;
      this.size -= tamActu;
      return "Actualización de tamaño $tamActu completada: $so $version $size GB libres";
    }
  }

  @override
  Programa duplicar() {
    MaquinaVirtual copia = MaquinaVirtual();
    copia.size = size;
    copia.so = so;
    copia.version = version;
    for (Programa p in this.hijos) {
      copia.hijos.add(p);
    }
    return copia;
  }

  @override
  void duplicar_programa(int i) {
    if (i == 0 || (i > 0 && i < hijos.length-1)){
      Programa copia = this.hijos[i];
      this.hijos.add(copia);
    }
  }
}