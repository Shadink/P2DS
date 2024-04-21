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
  TextEditingController _versionController = TextEditingController();
  TextEditingController _sizeController = TextEditingController();

  Widget filaBotones(Programa prog, int tab, Programa padre) {
  String t = '';
  for (int i=0 ; i<tab ; i++) t += '\t';
  return Column(
    children: [
      Row(
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
                prog.agregar(_directorl.construir_MV());
              });
            },
            child: Text('Agregar Linux'),
          ),
          SizedBox(width: 20.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                prog.agregar(_directorw.construir_MV());
              });
            },
            child: Text('Agregar Windows'),
          ),
          SizedBox(width: 20.0),
          IconButton(
            icon: Icon(Icons.update),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Actualizar Máquina Virtual'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Versión:'),
                          TextField(
                            controller: _versionController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Versión',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Tamaño en GB:'),
                          TextField(
                            controller: _sizeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Tamaño de la actualización (GB)',
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          String version = _versionController.text;
                          int size = int.tryParse(_sizeController.text) ?? 0;
                          String result = prog.actualizar(version, size);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(result, style: TextStyle(color: Colors.black),),
                            backgroundColor: Color.fromARGB(255, 194, 220, 255),
                          ));
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                        child: Text('Actualizar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          SizedBox(width: 20.0),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                if (padre == prog)
                  root.removeAt(root.indexOf(prog));
                else
                  padre.quitar(prog);
              });
            },
          ),
        ],
      ),
      if (prog.hijos.isNotEmpty)
        Column(
          children: prog.hijos.map((childProg) => filaBotones(childProg, tab+2, prog)).toList(),
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
                      root.add(_directorl.construir_MV());
                    });
                  },
                  child: Text('Agregar Máquina Virtual Linux'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      root.add(_directorw.construir_MV());
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
                  return Container(
                    color: index.isEven ? Colors.grey.shade200 : null,
                    child: ListTile(
                      title: filaBotones(root[index], 2, root[index]),
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
