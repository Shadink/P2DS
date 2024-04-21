import 'maquinavirtual.dart';
import 'programa.dart';

abstract class MVBuilder{
  List<Programa> hijos = [];
  late MaquinaVirtual mv;

  void crearNuevaMV(){
    mv = MaquinaVirtual();
  }

  void anadirSO();
  void anadirVersion();
  void anadirTamano();
}