



class Dewar{
  String number;
  String dewarType;
  String gasType;
  String comment;
  bool hot;
  bool cold;
  bool highPressure;
  bool lowPressure;
  String time;
  String date;


  Dewar({this.date, this.number, this.dewarType,this.gasType, this.comment, this.cold, this.hot, this.highPressure,this.lowPressure, this.time});

  String toParams() =>
      "?date=$date&number=$number&dewarType=$dewarType&gasType=$gasType&hot=$hot&cold=$cold&time=$time&highPressure=$highPressure&lowPressure=$lowPressure&comment=$comment";

}