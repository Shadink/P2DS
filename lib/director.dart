import 'package:ejgrupal/linuxbuilder.dart';

import 'mvbuilder.dart';

class Director{
  MVBuilder builder = LinuxBuilder();

  Director(MVBuilder n_builder){
    builder = n_builder;
  }

  void build_mv(){
    builder.createNewMv();
    builder.addSo();
    builder.addVersion();
    builder.addSize(); 
  }
}