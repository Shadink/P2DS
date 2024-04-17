import 'Programa.dart';

class ProgramaNormal extends Programa {
    String nombre;

    ProgramaNormal(this.nombre);

    @override
    void mostrar() {
        print("Programa de nombre $nombre");
    }
}

