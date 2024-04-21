import 'mvbuilder.dart';

class WindowsBuilder extends MVBuilder{

  @override
  void addSo(){
    mv.so = "Windows";
  }

  @override
  void addVersion(){
    mv.version = "11";
  }

  @override
  void addSize(){
    mv.size = 64;
  }
}