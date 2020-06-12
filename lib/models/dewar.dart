


import 'package:flutter/foundation.dart';

class Dewar with ChangeNotifier{
  String number;
  String dewarType;
  String gasType;
  String comment;
  bool hot;
  bool cold;
  bool highPressure;
  bool lowPressure;
  String time;


  Dewar({this.number, this.dewarType,this.gasType, this.comment, this.cold, this.hot, this.highPressure,this.lowPressure, this.time});


}