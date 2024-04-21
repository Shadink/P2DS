abstract class Programa {
  List<Programa> hijos = [];

    String mostrar();
    void agregar(Programa n);
    void quitar(int i);
    Programa obtener(int i);
    String ejecutar();
    String detener();
    Programa duplicar();
    void actualizar(String version, int tamActu);
    void duplicar_programa(int i);
    
}
