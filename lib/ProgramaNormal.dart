import 'programa.dart';

class ProgramaNormal extends Programa {
    String nombre;

    ProgramaNormal(this.nombre);

    @override
    String mostrar() {
        return "Programa de nombre $nombre";
    }

    @override
    void agregar(Programa n) {
        // Sin funcionalidad adicional
    }

    @override
    void quitar(int i) {
        // Sin funcionalidad adicional
    }
}

