
import 'programa.dart';

class MaquinaVirtual extends Programa {
    String so = "";
    String version = "";
    int size = 0;
    List<Programa> hijos = [];

    @override
    String mostrar(){
        String salida = "Máquina virtual $version que contiene:";
        for (Programa p in hijos){
            salida += p.mostrar();
        }
        return salida;
    }

    void agregar(Programa n){
        hijos.add(n);
    }           

    void quitar(int i){
        hijos.removeAt(i);
    }
}