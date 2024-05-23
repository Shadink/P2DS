import 'dart:convert';

import 'package:ejgrupal/ProgramaNormal.dart';

import 'Programa.dart';

import 'maquinavirtual.dart';
import 'Programa.dart';
import 'package:http/http.dart' as http;

class Sesion {
  List<Programa> root = [];
  final String apiUrl = "http://localhost:3000/programas";

  Sesion();

  int tamanio() {
    return root.length;
  }

  Future<void> cargarPrograma(String usuario) async {
    root.clear();
    final response = await http.get(Uri.parse('$apiUrl?usuario=$usuario'));
    if (response.statusCode == 200) {
      List<dynamic> programasJson = json.decode(response.body);

      root.clear();

      root.addAll(
          programasJson.map((json) => Programa.fromJson(json)).toList());

      for (Programa p in root) {
        if (p.tipo == "MV") {
          p = p as MaquinaVirtual;
        } else {
          p = p as ProgramaNormal;
        }
      }
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> agregar(Programa programa) async {
    if (programa.tipo == "MV") {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode((programa as MaquinaVirtual).toJson()),
      );
      if (response.statusCode == 201) {
        root.add(MaquinaVirtual.fromJson(json.decode(response.body)));
      } else {
        throw Exception('Failed to add task: ${response.body}');
      }
    } else {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode((programa as ProgramaNormal).toJson()),
      );
      if (response.statusCode == 201) {
        root.add(ProgramaNormal.fromJson(json.decode(response.body)));
      } else {
        throw Exception('Failed to add task: ${response.body}');
      }
    }
  }

  Future<void> eliminar(Programa programa) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/${programa.id}'),
    );
    if (response.statusCode == 200) {
      root.removeWhere((t) => t.id == programa.id);
    } else {
      throw Exception('Failed to delete task');
    }
  }

  Programa get(int i) {
    return root[i];
  }
}
