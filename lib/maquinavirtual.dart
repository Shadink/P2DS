
import 'programa.dart';

class MaquinaVirtual extends Programa {
    String so = "";
    String version = "";
    int size = 0;

    @override
    String mostrar(){
        String salida = "Máquina virtual $version:\n\t";
        for (Programa p in hijos){
            salida += p.mostrar();
        }
        return salida;
    }

    @override
    void agregar(Programa n){
        hijos.add(n);
    }           

    @override
    void quitar(int i){
        hijos.removeAt(i);
    }
}