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
  const MyApp({super.key});

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
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MVBuilder _windows = WindowsBuilder();
  final MVBuilder _linux = LinuxBuilder();
  late Director _directorw = Director(_windows);
  late Director  _directorl = Director(_linux);
  late Programa p;
  List<Programa> root = [];
  TextEditingController _controller = TextEditingController();

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
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      root.add(_directorl.build_mv());
                    });
                  },
                  child: Text('Agregar Máquina Virtual Linux'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      root.add(_directorw.build_mv());
                    });
                  },
                  child: Text('Agregar Máquina Virtual Windows'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: root.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(root[index].mostrar()),
                        ),
                        Expanded(
                          child: Row(
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
                                          root[index].agregar(p);
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              ElevatedButton(
                                onPressed: () {
                                  if (_controller.text.isNotEmpty) {
                                    p = ProgramaNormal(_controller.text);
                                    setState(() {
                                      root[index].agregar(p);
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
                            ],
                          ),
                        ),
                        SizedBox(width: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              root[index].agregar(_directorl.build_mv());
                            });
                          },
                          child: Text('Agregar Linux'),
                        ),
                        SizedBox(width: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              root[index].agregar(_directorw.build_mv());
                            });
                          },
                          child: Text('Agregar Windows'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
}
