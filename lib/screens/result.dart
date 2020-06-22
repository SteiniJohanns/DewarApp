import 'package:MyProviderApp/models/dewar.dart';
import 'package:flutter/material.dart';

class FillingResult extends StatelessWidget {
  final Dewar myFillingResult;
  const FillingResult({Key key, this.myFillingResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(myFillingResult.dewarType);

    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          //alignment: Alignment.center,
          color: Colors.blueGrey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[myText('Áfyllingu lokið', 30)],
              ),
              SizedBox(height: 20),
              Divider(
                thickness: 3,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      myText('Númer', 20),
                      myText('Gas', 20),
                      myText('Tegund', 20),
                      myText('Ástand', 20),
                      myText('Gerð', 20),
                      myText('Áfyllitími', 20),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      myText(myFillingResult.number, 20),
                      myText(myFillingResult.gasType, 20),
                      myText(myFillingResult.dewarType, 20),
                      myText(myFillingResult.hot ? 'Heitur' : 'Kaldur', 20),
                      myText(
                          myFillingResult.highPressure
                              ? 'Háþrýstur'
                              : 'Lágþrýstur',
                          20),
                      myText(myFillingResult.time, 20),
                    ],
                  ),
                ],
              ),
              Divider(
                thickness: 3,
                color: Colors.white,
              ),
              SizedBox(height: 50),
              Center(
                child: FlatButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: Text(
                      'Vista',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    color: Colors.blue,
                    padding: EdgeInsets.all(50),
                    shape: CircleBorder()),
              ),
            ],
          )),
    );
  }

  myText<Widget>(String text, double textSize) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Text(
        text != null ? text : '',
        style: TextStyle(fontSize: textSize, color: Colors.white),
      ),
    );
  }
}
