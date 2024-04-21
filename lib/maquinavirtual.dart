
import 'programa.dart';
import 'package:deepcopy/deepcopy.dart';

class MaquinaVirtual extends Programa {
    String so = "";
    String version = "";
    int size = 0;

    @override
    String mostrar(){
        return "Máquina virtual version:$version:\n
                Sistema operativo: $so\n
                Tamaño: $size\n";
    }

    @override
    void agregar(Programa n){
        hijos.add(n);
    }           

    @override
    void quitar(int i){
        hijos.removeAt(i);
    }

    @override
    Programa obtener(int i){
        if(i < hijos.length)
            return hijos[i];
        else
            return null;
    }

    @override 
    String ejecutar(){
        return "Ejecutando máquina virtual $version";
    }

    @override
    String detener(){
        return "Deteniendo máquina virtual $version";
    }

    @override
    Programa duplicar(){
        MaquinaVirtual copia = deepcopy(this);
        copia.hijos = [];
        for(Programa p in this.hijos){
            copia.hijos.add(p.duplicar());
        }
        return copia;
    }

    @override
    void actualizar(String version, int tamActu){
        if(this.size - tamActu < 0){
            print("No hay suficiente espacio en la máquina virtual para la actualización");
            return;
        }
        this.version = version;
        this.size -= tamActu;
    }

    @override
    void duplicar_programa(int i){
        if(i >= this.hijos.length)
            return "No existe el programa";
        Programa copia = this.hijos[i].duplicar();
        this.hijos.add(copia);
    }
}