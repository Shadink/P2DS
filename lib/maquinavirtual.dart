//import 'dart:io';

import 'Programa.dart';
import 'ProgramaNormal.dart';

class MaquinaVirtual extends Programa {
  String? so = "";
  String? version = "";
  int? size = 0;
  String usuario;
  int id;

  MaquinaVirtual(this.id, this.so, this.version, this.size, this.usuario);
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
    if (i <= 0)
      i = 0;
    else if (i > hijos.length - 1) i = hijos.length - 1;

    return hijos[i];
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
    if ((this.size ?? 0) - tamActu < 0) {
      return "No hay suficiente espacio en la máquina virtual para la actualización";
    } else {
      this.version = version;
      this.size = (this.size ?? 0) - tamActu;
      return "Actualización de tamaño $tamActu completada: $so $version $size GB libres";
    }
  }

  @override
  Programa duplicar() {
    MaquinaVirtual copia = MaquinaVirtual(id, so, version, size, usuario);
    copia.size = size;
    copia.so = so;
    copia.version = version;

    if (hijos.isNotEmpty) {
      for (Programa p in hijos) {
        Programa hijo = p.duplicar();
        copia.agregar(hijo);
      }
    }

    return copia;
  }

  @override
  void duplicar_programa(int i) {
    if (i >= 0 && i < hijos.length - 1) {
      Programa copia = this.hijos[i].duplicar();
      this.agregar(copia);
    }
  }

  @override
  bool sonIguales(Programa p) {
    bool iguales = false;
    if (p is MaquinaVirtual) {
      MaquinaVirtual mv = p as MaquinaVirtual;
      if (this.so == mv.so &&
          this.version == mv.version &&
          this.size == mv.size) {
        iguales = true;
        if (this.hijos.length != mv.hijos.length) {
          iguales = false;
        } else {
          for (int i = 0; i < hijos.length; i++) {
            if (!this.hijos[i].sonIguales(mv.hijos[i])) {
              iguales = false;
              break;
            }
          }
        }
      }
    }
    return iguales;
  }

  factory MaquinaVirtual.fromJson(Map<String, dynamic> json) {
    return MaquinaVirtual(
        json['id'] as int,
        json['so'] as String?,
        json['version'] as String?,
        json['size'] as int?,
        json['usuario'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'so': so,
      'version': version,
      'size': size,
      'usuario': usuario
    };
  }
}
