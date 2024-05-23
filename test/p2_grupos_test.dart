import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/maquinavirtual.dart';
import '../lib/ProgramaNormal.dart';
import '../lib/mvbuilder.dart';
import '../lib/windowsbuilder.dart';
import '../lib/linuxbuilder.dart';
import '../lib/director.dart';
import '../lib/Programa.dart';
import '../lib/sesion.dart';

void main() {
  group('Base de datos', () {
    Sesion root = Sesion();
    String currentUser = "Prueba";
    Programa p = ProgramaNormal("Nombre", 0, currentUser);
    test('Agregar programa', () async {
      await root.agregar(p);
      expect(root.root.length, 1);
    });
    test('Carga programas correctamente', () async {
      await root.cargarPrograma("Carlos");
      await root.cargarPrograma(currentUser);
      expect(root.root.length, 1);
    });

    test('Eliminar programas correctamente', () async {
      await root.eliminar(p);
      expect(root.root.length, 0);
    });
  });
  group('Máquina Virtual', () {
    MVBuilder linux = LinuxBuilder();
    MVBuilder windows = WindowsBuilder();
    Director directorl = Director(linux);
    Director directorw = Director(windows);
    MaquinaVirtual mv_l = directorl.construir_MV("Carlos");
    MaquinaVirtual mv_w = directorw.construir_MV("Carlos");
    ProgramaNormal p = ProgramaNormal("Programa base", 0, "Carlos");

    test('Construir una MV', () {
      expect([
        [mv_l.so, mv_l.version, mv_l.size],
        [mv_w.so, mv_w.version, mv_w.size]
      ], [
        ["Ubuntu", "22", 32],
        ["Windows", "11", 64]
      ]);
    });
    test('Agregar programa nuevo a MV', () {
      mv_l.hijos = [p, mv_w];
      ProgramaNormal n = ProgramaNormal("Programa nuevo", 0, "Carlos");
      mv_l.agregar(n);
      expect(mv_l.hijos, [p, mv_w, n]);
    });

    test('Agregar programa existente a MV', () {
      mv_l.hijos = [p, mv_w];
      mv_l.agregar(p);
      expect(mv_l.hijos, [p, mv_w, p]);
    });

    test('Agregar mv nueva a MV', () {
      mv_l.hijos = [p, mv_w];
      mv_l.agregar(mv_l);
      expect(mv_l.hijos, [p, mv_w, mv_l]);
    });

    test('Agregar mv existente a MV', () {
      mv_l.hijos = [p, mv_w];
      mv_l.agregar(mv_w);
      expect(mv_l.hijos, [p, mv_w, mv_w]);
    });

    test('Quitar programa existente a MV', () {
      mv_l.hijos = [p, mv_w];
      mv_l.quitar(mv_w);
      expect(mv_l.hijos, [p]);
    });

    test('Quitar programa inexistente a MV', () {
      mv_l.hijos = [p, mv_w];
      mv_l.quitar(mv_l);
      expect(mv_l.hijos, [p, mv_w]);
    });

    test('Obtener programa de MV introduciendo índice correcto', () {
      mv_l.hijos = [p, mv_w];
      expect([mv_l.obtener(0), mv_l.obtener(1)], [p, mv_w]);
    });

    test('Obtener programa de MV introduciendo índice superior y negativo', () {
      mv_l.hijos = [p, mv_w];
      expect([mv_l.obtener(10), mv_l.obtener(-10)], [mv_w, p]);
    });

    test('Actualizar MV con actualización mayor al tamaño', () {
      String version = mv_l.version;
      int tam = mv_l.size;
      mv_l.actualizar("Versión X", mv_l.size + 1);
      expect([mv_l.version, mv_l.size], [version, tam]);
    });

    test('Actualizar MV con actualización menor al tamaño', () {
      int tam = mv_l.size;
      mv_l.actualizar("Versión X", 1);
      expect([mv_l.version, mv_l.size], ["Versión X", tam - 1]);
    });

    test('Actualizar MV con actualización de tamaño negativo', () {
      int tam = mv_l.size;
      mv_l.actualizar("Versión Y", -mv_l.size);
      expect([mv_l.version, mv_l.size], ["Versión Y", 2 * tam]);
    });

    test('Duplicar un programa en MV introduciendo índice correcto', () {
      mv_l.hijos = [p, mv_w];
      mv_l.duplicar_programa(0);
      mv_l.duplicar_programa(1);
      expect([p.sonIguales(mv_l.obtener(2)), mv_w.sonIguales(mv_l.obtener(3))],
          [true, true]);
    });

    test("Duplicar un programa en MV introduciendo índice superior y negativo",
        () {
      mv_l.hijos = [p, mv_w];
      mv_l.duplicar_programa(10);
      mv_l.duplicar_programa(-10);
      expect(mv_l.hijos, [p, mv_w]);
    });
  });

  group('Programa Normal', () {
    ProgramaNormal a = ProgramaNormal("Programa a", 0, "Carlos");
    ProgramaNormal b = ProgramaNormal("Programa b", 0, "Carlos");
    ProgramaNormal c = ProgramaNormal("Programa c", 0, "Carlos");

    test('Agregar y quitar programas de un Programa Normal', () {
      a.agregar(b);
      a.agregar(b);
      a.agregar(c);
      a.quitar(b);
      expect(a.hijos, []);
    });

    test('Obtener programa de un Programa Normal', () {
      expect([a.obtener(-10), a.obtener(0), a.obtener(10)], [a, a, a]);
    });

    test('Actualizar un Programa Normal', () {
      expect(b.actualizar("Versión W", 1), "Programa normal no se actualiza");
    });

    test('Duplicar un programa de Programa Normal', () {
      a.duplicar_programa(-10);
      a.duplicar_programa(0);
      a.duplicar_programa(10);
      expect(a.hijos, []);
    });
  });
}
