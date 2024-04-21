import 'dart:collection';

import 'package:flutter/material.dart';
import 'director.dart';
import 'mvbuilder.dart';
import 'windowsbuilder.dart';
import 'linuxbuilder.dart';
import 'maquinavirtual.dart';
import 'programa.dart';
import 'programanormal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Máquinas Virtuales',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Máquinas Virtuales'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MVBuilder _windows = WindowsBuilder();
  final MVBuilder _linux = LinuxBuilder();
  late Director _directorw = Director(_windows);
  late Director _directorl = Director(_linux);
  late Programa p;
  List<Programa> root = [];
  TextEditingController _controller = TextEditingController();
  Map<Programa, GlobalKey> clavesProgramas = {};

  void borrarProgramaYHijos(Programa programa) {
    // Eliminar el programa y su clave asociada
    root.remove(programa);
    clavesProgramas.remove(programa);

    // Eliminar los widgets hijos y sus claves asociadas recursivamente
    for (var hijo in programa.hijos) {
      borrarProgramaYHijos(hijo);
    }
  }

  Widget filaBotones(Programa prog, int tab, GlobalKey key) {
    String t = '';
    for (int i = 0; i < tab; i++) t += '\t';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(t + prog.mostrar()),
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  p = ProgramaNormal(_controller.text);
                  setState(() {
                    prog.agregar(p);
                    _controller.clear();
                  });
                }
              },
              child: Text(
                'Agregar Programa',
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 38, 255),
                ),
              ),
            ),
            SizedBox(width: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  var maquinaLinux = _directorl.build_mv();
                  clavesProgramas.putIfAbsent(maquinaLinux, () => GlobalKey());

                  prog.agregar(maquinaLinux);
                });
              },
              child: Text('Agregar Linux'),
            ),
            SizedBox(width: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  var maquinaWindows = _directorw.build_mv();
                  clavesProgramas.putIfAbsent(
                      maquinaWindows, () => GlobalKey());

                  prog.agregar(maquinaWindows);
                });
              },
              child: Text('Agregar Windows'),
            ),
            SizedBox(width: 20.0),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  borrarProgramaYHijos(prog);
                });
              },
            ),
          ],
        ),
        if (prog.hijos.isNotEmpty)
          Column(
            children: prog.hijos.map((childProg) {
              clavesProgramas.putIfAbsent(childProg, () => GlobalKey());

              return filaBotones(
                  childProg, tab + 2, clavesProgramas[childProg]!);
            }).toList(),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: 'Programa',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 38, 255),
                            ),
                          ),
                          onSubmitted: (String nombre) {
                            if (nombre.isNotEmpty) {
                              p = ProgramaNormal(nombre);
                              setState(() {
                                clavesProgramas.putIfAbsent(
                                    p, () => GlobalKey());
                                root.add(p);
                                _controller.clear();
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      p = ProgramaNormal(_controller.text);
                      setState(() {
                        clavesProgramas.putIfAbsent(p, () => GlobalKey());
                        root.add(p);
                        _controller.clear();
                      });
                    }
                  },
                  child: Text(
                    'Agregar Programa',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 38, 255),
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      var maquinaLinux = _directorl.build_mv();
                      root.add(
                          maquinaLinux); // Agregar la máquina virtual Linux a la lista root
                      clavesProgramas.putIfAbsent(
                          maquinaLinux, () => GlobalKey());
                    });
                  },
                  child: Text('Agregar Máquina Virtual Linux'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      var maquinaWindows = _directorw.build_mv();
                      root.add(
                          maquinaWindows); // Agregar la máquina virtual Windows a la lista root
                      clavesProgramas.putIfAbsent(
                          maquinaWindows, () => GlobalKey());
                    });
                  },
                  child: Text('Agregar Máquina Virtual Windows'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: root.length,
                itemBuilder: (context, index) {
                  Programa programaActual = root[index];

                  clavesProgramas.putIfAbsent(
                      programaActual, () => GlobalKey());
                  return Container(
                    color: index.isEven ? Colors.grey.shade200 : null,
                    child: ListTile(
                      title: filaBotones(
                          root[index], 2, clavesProgramas[programaActual]!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
