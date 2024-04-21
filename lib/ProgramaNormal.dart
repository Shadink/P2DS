import 'programa.dart';
import 'package:deepcopy/deepcopy.dart';

class ProgramaNormal extends Programa {
    String nombre;

    ProgramaNormal(this.nombre);

    @override
    String mostrar() {
        return "Programa de nombre $nombre\n";
    }

    @override
    void agregar(Programa n) {
        // Sin funcionalidad adicional
    }

    @override
    void quitar(int i) {
        // Sin funcionalidad adicional
    }

    @override
    Programa obtener(int i) {
        // Sin funcionalidad adicional
    }

    @override
    String ejecutar() {
        return "Ejecutando programa $nombre";
    }

    @override
    String detener() {
        return "Deteniendo programa $nombre";
    }

    @override
    Programa duplicar() {
        ProgamaNormal copia = deepcopy(this);
        return copia;
    }

    @override
    void actualizar(String version, int tamActu) {
        // Sin funcionalidad adicional
    }

    @override
    void duplicar_programa(int i) {
        // Sin funcionalidad adicional
    }

}

