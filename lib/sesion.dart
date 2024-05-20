import 'dart:convert';

//import 'maquinavirtual.dart';
import 'programa.dart';
import 'package:http/http.dart' as http;

class Sesion {
  List<Programa> root = [];
  final String apiUrl = "http://localhost:3000/programas";

  Sesion(this.root);

  Future<void> cargarPrograma(String usuario) async {
    final response = await http.get(Uri.parse('$apiUrl?usuario=$usuario'));
    if (response.statusCode == 200) {
      List<dynamic> programasJson = json.decode(response.body);

      root.clear();

      root.addAll(
          programasJson.map((json) => Programa.fromJson(json)).toList());
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> agregar(Programa programa) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(programa.toJson()),
    );
    if (response.statusCode == 201) {
      root.add(Programa.fromJson(json.decode(response.body)));
    } else {
      throw Exception('Failed to add task: ${response.body}');
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
}
