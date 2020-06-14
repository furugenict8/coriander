import 'package:flutter/cupertino.dart';

class MainModel extends ChangeNotifier{
  String kboyText = 'Kboy';

  void changeKboyText(){
    kboyText = 'Kboyさんかっこいい';
    notifyListeners();//変更したことを通知する
  }
}