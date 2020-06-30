import 'dart:async';

import 'package:MyProviderApp/models/consts_routes.dart';
import 'package:MyProviderApp/models/dewar.dart';
import 'package:flutter/material.dart';

class TimeKeeper extends StatefulWidget {
  final Dewar myDewar;
  const TimeKeeper({Key key, @required this.myDewar}) : super(key: key);

  @override
  _TimeKeeperState createState() => _TimeKeeperState(key, myDewar);
}

class _TimeKeeperState extends State<TimeKeeper> {
  final myDewar;
  _TimeKeeperState(Key key, this.myDewar);

  String myClock = '00:00:00';
  int sek = 0;
  Timer myTimer;
  Color btnColor = Colors.red;
  bool lowHigh = false;
  bool hotCold = false;
  bool listen = false;

  @override
  void initState() {
    super.initState();
    if (myTimer != null) {
      myTimer.cancel();
    }
    startTimer();
    listen = true;
  }

  @override
  void dispose() {
    listen = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Áfylling í gangi'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: FlatButton(
                child: Text(
                  'Bæta við baukanúmeri',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  showDialog(context: context, builder: (_) => _numberDialog()                  
                  );
                },
                onLongPress: () {},
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            Container(
              child: FlatButton(
                child: Text('Bæta við athugasemd',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  showDialog(context: context, builder: (_) => _commentDialog()                  
                  );
                },
                onLongPress: () {},
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
            child: SingleChildScrollView(
                          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Container(
                  child:
                      Text(myDewar.number != null ? myDewar.number :'Áfylling í gangi', style: TextStyle(fontSize: 30))),
              SizedBox(height: 60),
              _lowHighRow(),
              _hotColdRow(),
              SizedBox(height: 60),
              Container(
                  child: Text(
                myClock == null ? 'Korter gengin af göflunum' : myClock,
                style: TextStyle(fontSize: 40),
              )),
              SizedBox(height: 60),
              FlatButton(
                  onPressed: () {},
                  onLongPress: () {
                    setState(() {
                      btnColor = Colors.green;
                      myDewar.hot = !hotCold;
                      myDewar.cold = hotCold;
                      myDewar.lowPressure = !lowHigh;
                      myDewar.highPressure = lowHigh;
                      myDewar.time = myClock;
                    });
                    myTimer.cancel();
                    Navigator.pushNamed(context, FillingResultViewRoute,
                        arguments: myDewar);
                  },
                  child: Text(
                    'Stopp',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  color: btnColor,
                  padding: EdgeInsets.all(50),
                  shape: CircleBorder()),
          ],
        ),
            )),
      ),
    );
  }

  AlertDialog _numberDialog(){
    return AlertDialog(
                    title: Text('Sláðu inn baukanúmer'),
                    content: TextFormField(
                      autofocus: true,
                      autocorrect: false,
                      onChanged: (value){
                        setState(() {
                          myDewar.number = value;
                        });
                    },),actions: <Widget>[
                      FlatButton.icon(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.check_circle, color:Colors.green,size: 60,),label: Text('')),
                    ],
                  );
  }
  AlertDialog _commentDialog(){
    return AlertDialog(
                    title: Text('Skráðu athugasemd'),
                    content: TextFormField(
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      autocorrect: false,
                      maxLines: 2,
                      onChanged: (value){
                        setState(() {
                          myDewar.comment = value;
                        });
                    },),actions: <Widget>[
                      FlatButton.icon(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.check_circle, color:Colors.green,size: 60,),label: Text('')),
                    ],
                  );
  }

  Row _lowHighRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
          child: Text(
            'Lágþrýstur',
            style: TextStyle(
                fontSize: 20, color: !lowHigh ? Colors.white : Colors.black),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: !lowHigh ? Colors.green : Colors.transparent),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Switch(
              value: lowHigh,
              onChanged: (_) {
                setState(() {
                  lowHigh = !lowHigh;
                });
              }),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
          child: Text(
            'Háþrýstur',
            style: TextStyle(
                fontSize: 20, color: lowHigh ? Colors.white : Colors.black),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: lowHigh ? Colors.red : Colors.transparent),
        ),
      ],
    );
  }

  Row _hotColdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
          child: Text(
            'Heitur',
            style: TextStyle(
                fontSize: 20, color: !hotCold ? Colors.white : Colors.black),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: !hotCold ? Colors.red : Colors.transparent),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Switch(
              value: hotCold,
              onChanged: (_) {
                setState(() {
                  hotCold = !hotCold;
                  print(hotCold);
                });
              }),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
          child: Text(
            'Kaldur',
            style: TextStyle(
                fontSize: 20, color: hotCold ? Colors.white : Colors.black),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: hotCold ? Colors.green : Colors.transparent),
        ),
      ],
    );
  }

  startTimer() {
    myTimer = Timer.periodic(Duration(seconds: 1), (f) {
      sek++;
      if (listen) {
        convertSeconds(sek);
      }
    });
  }

  convertSeconds(int sek) {
    int sec, min, hour;
    String clock;

    hour = (sek / 3600).floor();
    min = ((sek / 3600 % 1) * 60).floor();
    sec = sek % 60.floor();

    clock = hour.toString().padLeft(2, '0') +
        ':' +
        min.toString().padLeft(2, '0') +
        ':' +
        sec.toString().padLeft(2, '0');

    setState(() {
      myClock = clock;
      //print(myClock);
    });
  }
}
