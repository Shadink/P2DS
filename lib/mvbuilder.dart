import 'maquinavirtual.dart';

abstract class MVBuilder{
  MaquinaVirtual mv = MaquinaVirtual();

  void createNewMv(){
    mv = MaquinaVirtual();
  }

  void addSo();
  void addVersion();
  void addSize();
}