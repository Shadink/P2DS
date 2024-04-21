import 'package:ejgrupal/linuxbuilder.dart';
import 'mvbuilder.dart';
import 'maquinavirtual.dart';

class Director{
  MVBuilder builder;

  Director(this.builder);

  MaquinaVirtual construir_MV(){
    builder.crearNuevaMV();
    builder.anadirSO();
    builder.anadirVersion();
    builder.anadirTamano(); 
    return builder.mv;
  }
}