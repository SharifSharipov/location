import 'package:flutter/material.dart';
class TabboxProvider extends ChangeNotifier{
   int activeindex=0;
   void checkIndex(int index){
     activeindex=index;
     notifyListeners();
   }
}