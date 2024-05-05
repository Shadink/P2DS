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
  test('Agregar programa nuevo a MV', () {
    MVBuilder linux = LinuxBuilder();
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    ProgramaNormal p = ProgramaNormal("Programa 1");
    mv_l.agregar(p);
    expect(mv_l.hijos, [p]);
  });

  test('Agregar programa existente a MV', () {
    MVBuilder linux = LinuxBuilder();
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    ProgramaNormal p = ProgramaNormal("Programa 1");
    mv_l.agregar(p);
    mv_l.agregar(p);
    expect(mv_l.hijos, [p, p]);
  });

  test('Agregar mv nueva a MV', () {
    MVBuilder windows = WindowsBuilder();
    MVBuilder linux = LinuxBuilder();
    Director directorw = Director(windows);
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    mv_l.agregar(mv_w);
    expect(mv_l.hijos, [mv_w]);
  });

  test('Agregar mv existente a MV', () {
    MVBuilder windows = WindowsBuilder();
    MVBuilder linux = LinuxBuilder();
    Director directorw = Director(windows);
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    mv_l.agregar(mv_w);
    mv_l.agregar(mv_w);
    expect(mv_l.hijos, [mv_w, mv_w]);
  });

  test('Quitar programa existente a MV', () {
    MVBuilder windows = WindowsBuilder();
    MVBuilder linux = LinuxBuilder();
    Director directorw = Director(windows);
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    mv_l.agregar(mv_w);
    mv_l.agregar(mv_w);
    mv_l.quitar(mv_w);
    expect(mv_l.hijos, [mv_w]);
  });

  test('Quitar programa inexistente a MV', () {
    MVBuilder windows = WindowsBuilder();
    MVBuilder linux = LinuxBuilder();
    Director directorw = Director(windows);
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    mv_l.agregar(mv_w);
    mv_l.agregar(mv_w);
    mv_l.quitar(mv_l);
    expect(mv_l.hijos, [mv_w, mv_w]);
  });

  test('Obtener programa de MV introduciendo índice correcto', () {
    MVBuilder windows = WindowsBuilder();
    MVBuilder linux = LinuxBuilder();
    Director directorw = Director(windows);
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    mv_l.agregar(mv_w);
    expect(mv_l.obtener(0), mv_w);
  });

  test('Obtener programa de MV introduciendo índice superior', () {
    MVBuilder windows = WindowsBuilder();
    MVBuilder linux = LinuxBuilder();
    Director directorw = Director(windows);
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    ProgramaNormal p = ProgramaNormal("Programa 1");
    mv_l.agregar(mv_w);
    mv_l.agregar(p);
    expect(mv_l.obtener(10), p);
  });

  test('Obtener programa de MV introduciendo índice negativo', () {
    MVBuilder windows = WindowsBuilder();
    MVBuilder linux = LinuxBuilder();
    Director directorw = Director(windows);
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    ProgramaNormal p = ProgramaNormal("Programa 1");
    mv_l.agregar(mv_w);
    mv_l.agregar(p);
    expect(mv_l.obtener(-10), mv_w);
  });

  test('Actualizar MV con actualización mayor al tamaño', () {
    MVBuilder linux = LinuxBuilder();
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    int tam = mv_l.size;
    mv_l.actualizar("Versión x", mv_l.size+1);
    expect(mv_l.size, tam);
  });

  test('Actualizar MV con actualización menor al tamaño', () {
    MVBuilder linux = LinuxBuilder();
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    int tam = mv_l.size;
    mv_l.actualizar("Versión x", mv_l.size-tam+1);
    expect(mv_l.size, tam-1);
  });

  test('Actualizar MV con actualización de tamaño negativo', () {
    MVBuilder linux = LinuxBuilder();
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    int tam = mv_l.size;
    mv_l.actualizar("Versión x", -mv_l.size);
    expect(mv_l.size, 2*tam);
  });

  test('Duplicar una MV', () {
    MVBuilder windows = WindowsBuilder();
    MVBuilder linux = LinuxBuilder();
    Director directorw = Director(windows);
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    mv_l.agregar(mv_w);
    mv_l.agregar(mv_w);
    Programa copia = mv_l.duplicar();
    expect(copia.hijos, [mv_w, mv_w]);
  });

  test('Duplicar una MV y que añadir y quitar programas a la copia no afecte a la original', () {
    MVBuilder windows = WindowsBuilder();
    MVBuilder linux = LinuxBuilder();
    Director directorw = Director(windows);
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    mv_l.agregar(mv_w);
    mv_l.agregar(mv_w);
    Programa copia = mv_l.duplicar();
    copia.quitar(mv_w);
    copia.agregar(mv_l);
    expect(mv_l.hijos, [mv_w, mv_w]);
  });

  test('Duplicar una MV y que actualizar la copia no afecte a la original', () {
    MVBuilder linux = LinuxBuilder();
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    String version = mv_l.version;
    int tam = mv_l.size;
    Programa copia = mv_l.duplicar();
    copia.actualizar("Versión Y", 1);
    expect([mv_l.version, mv_l.size], [version, tam]);
  });

  test('Duplicar un programa en MV introduciendo índice correcto', () {
    MVBuilder windows = WindowsBuilder();
    MVBuilder linux = LinuxBuilder();
    Director directorw = Director(windows);
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    mv_l.agregar(mv_w);
    mv_l.duplicar_programa(0);
    expect(mv_l.hijos, [mv_w, mv_w]);
  });

  test('Duplicar un programa en MV introduciendo índice superior', () {
    MVBuilder windows = WindowsBuilder();
    MVBuilder linux = LinuxBuilder();
    Director directorw = Director(windows);
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    ProgramaNormal p = ProgramaNormal("Programa 1");
    mv_l.agregar(mv_w);
    mv_l.agregar(p);
    mv_l.duplicar_programa(10);
    expect(mv_l.hijos, [mv_w, p]);
  });

  test('Duplicar programa en MV introduciendo índice negativo', () {
    MVBuilder windows = WindowsBuilder();
    MVBuilder linux = LinuxBuilder();
    Director directorw = Director(windows);
    Director directorl = Director(linux);
    MaquinaVirtual mv_l = directorl.construir_MV();
    MaquinaVirtual mv_w = directorw.construir_MV();
    ProgramaNormal p = ProgramaNormal("Programa 1");
    mv_l.agregar(mv_w);
    mv_l.agregar(p);
    mv_l.duplicar_programa(-10);
    expect(mv_l.hijos, [mv_w, p]);
  });

  test('Agregar y quitar programas de un Programa Normal', () {
    ProgramaNormal p = ProgramaNormal("Programa 1");
    p.agregar(ProgramaNormal("a"));
    p.agregar(ProgramaNormal("a"));
    p.agregar(ProgramaNormal("b"));
    p.quitar(ProgramaNormal("a"));
    expect(p.hijos, []);
  });

  test('Obtener programa de un Programa Normal', () {
    ProgramaNormal p = ProgramaNormal("Programa 1");
    p.agregar(ProgramaNormal("a"));
    p.agregar(ProgramaNormal("a"));
    p.agregar(ProgramaNormal("b"));
    p.quitar(ProgramaNormal("a"));
    expect([p.obtener(-10), p.obtener(0), p.obtener(10)], [p, p, p]);
  });

  test('Actualizar un Programa Normal', () {
    ProgramaNormal p = ProgramaNormal("Programa 1");
    expect(p.actualizar("Versión Z", 1), "Programa normal no se actualiza");
  });

  test('Duplicar un Programa Normal', () {
    ProgramaNormal p = ProgramaNormal("Programa 1");
    Programa copia = p.duplicar();
    expect((copia as ProgramaNormal).nombre, "Programa 1 - copia");
  });

  test('Duplicar un programa de Programa Normal', () {
    ProgramaNormal p = ProgramaNormal("Programa 1");
    p.agregar(ProgramaNormal("c"));
    p.duplicar_programa(-10);
    p.duplicar_programa(0);
    p.duplicar_programa(10);
    expect(p.hijos, []);
  });
}