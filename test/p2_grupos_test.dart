import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/maquinavirtual.dart';
import '../lib/programanormal.dart';
import '../lib/mvbuilder.dart';
import '../lib/windowsbuilder.dart';
import '../lib/linuxbuilder.dart';
import '../lib/director.dart';
import '../lib/programa.dart';


void main() {
  group('Máquina Virtual', () {
    MVBuilder linux = LinuxBuilder();
    MVBuilder windows = WindowsBuilder();
    Director directorl = Director(linux);
    Director directorw = Director(windows);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    ProgramaNormal p = ProgramaNormal("Programa base");

    test('Construir una MV', () {
      expect([[mv_l.so, mv_l.version, mv_l.size], [mv_w.so, mv_w.version, mv_w.size]], [["Ubuntu", "22", 32], ["Windows", "11", 64]]);
    });
    test('Agregar programa nuevo a MV', () {
      mv_l.hijos = [p, mv_w];
      ProgramaNormal n = ProgramaNormal("Programa nuevo");
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

    test ('Quitar programa existente a MV', () {
      mv_l.hijos = [p, mv_w];
      mv_l.quitar(mv_w);
      expect(mv_l.hijos, [p]);
    });

    test ('Quitar programa inexistente a MV', () {
      mv_l.hijos = [p, mv_w];
      mv_l.quitar(mv_l);
      expect(mv_l.hijos, [p, mv_w]);
    });

    test ('Obtener programa de MV introduciendo índice correcto', () {
      mv_l.hijos = [p, mv_w];
      expect([mv_l.obtener(0), mv_l.obtener(1)], [p, mv_w]);
    });

    test ('Obtener programa de MV introduciendo índice superior y negativo', () {
      mv_l.hijos = [p, mv_w];
      expect([mv_l.obtener(10), mv_l.obtener(-10)], [mv_w, p]);
    });

    test('Actualizar MV con actualización mayor al tamaño', () {
      String version = mv_l.version;
      int tam = mv_l.size;
      mv_l.actualizar("Versión X", mv_l.size+1);
      expect([mv_l.version, mv_l.size], [version, tam]);
    });

    test('Actualizar MV con actualización menor al tamaño', () {
      int tam = mv_l.size;
      mv_l.actualizar("Versión X", 1);
      expect([mv_l.version, mv_l.size], ["Versión X", tam-1]);
    });

    test('Actualizar MV con actualización de tamaño negativo', () {
      int tam = mv_l.size;
      mv_l.actualizar("Versión Y", -mv_l.size);
      expect([mv_l.version, mv_l.size], ["Versión Y", 2*tam]);
    });

    test('Duplicar una MV', () {
      mv_l.hijos = [p, mv_w];
      Programa copia = mv_l.duplicar();
      expect(mv_l.sonIguales(copia), true);
    });

    test('Duplicar una MV y que añadir programas a la copia no afecte a la original', () {
      mv_l.hijos = [p, mv_w]; // original con [p, mv_w]
      Programa copia = mv_l.duplicar();
      copia.agregar(mv_l); // copia con [p, mv_w, mv_l]
      expect(mv_l.sonIguales(copia), false);
    });

    test("Duplicar una MV y que añadir programas a elementos de la copia no afecte a la original", () {
      mv_l.hijos = [p, mv_w]; // original con [p, mv_w]
      Programa copia = mv_l.duplicar(); // hijos = [p, mv_w], mv_w vacía
      Programa hijo = copia.obtener(1); // mv_w de copia
      hijo.agregar(mv_l); // mv_w con mv_l
      expect(mv_l.sonIguales(copia), false);
    });

    test('Duplicar una MV y que actualizar la copia no afecte a la original', () {
      Programa copia = mv_l.duplicar();
      copia.actualizar("Versión Z", 1);
      expect(mv_l.sonIguales(copia), false);
    });

    test('Duplicar un programa en MV introduciendo índice correcto', () {
      mv_l.hijos = [p, mv_w];
      mv_l.duplicar_programa(0);
      mv_l.duplicar_programa(1);
      expect([p.sonIguales(mv_l.obtener(2)), mv_w.sonIguales(mv_l.obtener(3))], [true, true]);
    });

    test("Duplicar un programa en MV introduciendo índice superior y negativo", () {
      mv_l.hijos = [p, mv_w];
      mv_l.duplicar_programa(10);
      mv_l.duplicar_programa(-10);
      expect(mv_l.hijos, [p, mv_w]);
    });
  });

  group('Programa Normal', () {
    ProgramaNormal a = ProgramaNormal("Programa a");
    ProgramaNormal b = ProgramaNormal("Programa b");
    ProgramaNormal c = ProgramaNormal("Programa c");

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

    test('Duplicar un Programa Normal', () {
      Programa copia = c.duplicar();
      expect(c.sonIguales(copia), true);
    });

    test('Duplicar un programa de Programa Normal', () {
      a.duplicar_programa(-10);
      a.duplicar_programa(0);
      a.duplicar_programa(10);
      expect(a.hijos, []);
    });
  });
}