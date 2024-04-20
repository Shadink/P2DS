import 'programa.dart';

class ProgramaNormal extends Programa {
    String nombre;

    ProgramaNormal(this.nombre);

    @override
    String mostrar() {
        return "Programa de nombre $nombre";
    }
}

