import 'maquinavirtual.dart';
import 'Programa.dart';

abstract class MVBuilder{
  List<Programa> hijos = [];
  MaquinaVirtual mv = MaquinaVirtual();

  void createNewMv(){
    mv = MaquinaVirtual();
  }

  void addSo();
  void addVersion();
  void addSize();
}