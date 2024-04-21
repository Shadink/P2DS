import 'mvbuilder.dart';

class LinuxBuilder extends MVBuilder{

  @override
  void anadirSO(){
    mv.so = "Ubuntu";
  }

  @override
  void anadirVersion(){
    mv.version = "22";
  }

  @override
  void anadirTamano(){
    mv.size = 32;
  }
}