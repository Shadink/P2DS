import 'programa.dart';

class MaquinaVirtual extends Programa{
  String so = "";
  String version = "";
  String size = "";
  List<Programa> hijos = [];

  void mostrar(){
    print("Máquina virtual que contiene:");
    for(int i = 0; i < hijos.length; i++){
      hijos[i].mostrar();
    }
  }

  void agregar(Programa n){
    hijos.add(n);
  }

  void quitar(Programa n){
    hijos.remove(n);
  }
}