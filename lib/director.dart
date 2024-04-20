import 'package:ejgrupal/linuxbuilder.dart';
import 'mvbuilder.dart';
import 'maquinavirtual.dart';

class Director{
  MVBuilder builder;

  Director(this.builder);

  MaquinaVirtual build_mv(){
    builder.createNewMv();
    builder.addSo();
    builder.addVersion();
    builder.addSize(); 
    return builder.mv;
  }
}