
import 'programa.dart';

class MaquinaVirtual extends Programa {
    String so = "";
    String version = "";
    int size = 0;

    @override
    String mostrar(){
        return "Máquina virtual $version:\n";
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