
part 'Programa.dart'

class MaquinaVirtual extends Programa {
    String so;
    String version;
    int size;
    list<Programa> hijos = [];

    MaquinaVirtual(this.so, this.version, this.size, this.hijos);

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