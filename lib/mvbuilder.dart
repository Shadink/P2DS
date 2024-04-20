import 'maquinavirtual.dart';
import 'programa.dart';

abstract class MVBuilder{
  List<Programa> hijos = [];
  late MaquinaVirtual mv;

  void createNewMv(){
    mv = MaquinaVirtual();
  }

  void addSo();
  void addVersion();
  void addSize();
}