import 'maquinavirtual.dart';
import 'programa.dart';

abstract class MVBuilder {
  List<Programa> hijos = [];
  late MaquinaVirtual mv;

  void crearNuevaMV(String usuario) {
    mv = MaquinaVirtual(0, "", "", 0, usuario);
  }

  void anadirSO();
  void anadirVersion();
  void anadirTamano();
}
