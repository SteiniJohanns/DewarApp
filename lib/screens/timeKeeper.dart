import 'dart:async';

import 'package:MyProviderApp/models/consts_routes.dart';
import 'package:MyProviderApp/models/dewar.dart';
import 'package:MyProviderApp/screens/result.dart';
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

  @override
  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Text(
              myDewar.number,
              style: TextStyle(fontSize: 20),
            )),
            SizedBox(height: 60),
            _lowHighRow(),
            _hotColdRow(),
            SizedBox(height: 60),
            Container(
                child: Text(
              myClock,
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

                    //print(myDewar);
                  });
                  myTimer.cancel();
                  Navigator.pushNamed(context, FillingResultViewRoute, arguments: myDewar);
                },
                child: Text(
                  'Stopp',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                color: btnColor,
                padding: EdgeInsets.all(50),
                shape: CircleBorder()),
          ],
        )),
      ),
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
      convertSeconds(sek);
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
      print(myTimer.tick);
    });
  }
}
