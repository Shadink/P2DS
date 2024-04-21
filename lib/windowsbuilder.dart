import 'mvbuilder.dart';

class WindowsBuilder extends MVBuilder{

  @override
  void anadirSO(){
    mv.so = "Windows";
  }

  @override
  void anadirVersion(){
    mv.version = "11";
  }

  @override
  void anadirTamano(){
    mv.size = 64;
  }
}