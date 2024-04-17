import 'mvbuilder.dart';

class LinuxBuilder extends MVBuilder{

  @override
  void addSo(){
    mv.so = "Ubuntu";
  }

  @override
  void addVersion(){
    mv.version = "Ubuntu 22";
  }

  @override
  void addSize(){
    mv.size = "32GB";
  }
}