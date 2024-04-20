import 'package:ejgrupal/linuxbuilder.dart';
import 'mvbuilder.dart';

class Director{
  MVBuilder builder;

  Director(this.builder);

  void build_mv(){
    builder.createNewMv();
    builder.addSo();
    builder.addVersion();
    builder.addSize(); 
  }
}