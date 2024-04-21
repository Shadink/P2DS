import 'programa.dart';

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
    void quitar(Programa n) {
        // Sin funcionalidad adicional
    }

    @override
    Programa obtener(int i) {
        return this;
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
        Programa copia = ProgramaNormal(this.nombre);
        return copia;
    }

    @override
    String actualizar(String version, int tamActu) {
        return 'Programa normal no se actualiza\n';
    }

    @override
    void duplicar_programa(int i) {
        // Sin funcionalidad adicional
    }

}

