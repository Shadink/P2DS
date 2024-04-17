
import 'Programa.dart';

class MaquinaVirtual extends Programa {
    String so = "";
    String version = "";
    int size = 0;
    List<Programa> hijos = [];

    @override
    void mostrar(){
        print("Máquina virtual que contiene:");
        for (Programa p in hijos){
            p.mostrar();
        }
    }

    void agregar(Programa n){
        hijos.add(n);
    }           

    void quitar(Programa i){
        hijos.remove(i);
    }
}