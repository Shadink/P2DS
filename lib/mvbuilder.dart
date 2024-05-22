import 'maquinavirtual.dart';
import 'programa.dart';

abstract class MVBuilder {
  List<Programa> hijos = [];
  late MaquinaVirtual mv;

  void crearNuevaMV() {
    mv = MaquinaVirtual(0, "", "", 0, "");
  }

  void anadirSO();
  void anadirVersion();
  void anadirTamano();
}
