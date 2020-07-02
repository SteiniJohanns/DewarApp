import 'package:MyProviderApp/models/consts_routes.dart';
import 'package:flutter/material.dart';

import 'models/dewar.dart';
import 'models/mock.dart';
import 'models/routes.dart' as router;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baukadæmið',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Alltaf að bauka'),
      onGenerateRoute: router.generateRoute,
      initialRoute: HomeViewRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();
  final String title;

  _MyHomePageState({Key key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title == null ? 'Hvað á að bauka núna!' : title),
        ),
        body: myContainer(context));
  }

  Container myContainer(BuildContext context) {
    final Dewar myDewar = Dewar();
    return Container(
      alignment: Alignment.center,
      child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text('Tímaskráning baukaáfyllingar',
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    validator: (value) {
                      if (value == null) {
                        return 'Veldu gastegund';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Gastegund',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 2))),
                    items: kGasType.map((String e) {
                      return DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        myDewar.gasType = value;
                      });
                    },
                    onSaved: (value) {
                      myDewar.gasType = value;
                    },
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    validator: (value) {
                      if (value == null) {
                        return 'Veldu baukategund';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Baukategund',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 2))),
                    items: kDewarType.map((String e) {
                      return DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        myDewar.dewarType = value;
                      });
                    },
                    onSaved: (value) {
                      myDewar.dewarType = value;
                    },
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: FlatButton(
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            _formkey.currentState.save();
                            _formkey.currentState.reset();
                            Navigator.of(context).pushNamed(TimeKeeperViewRoute,
                                arguments: myDewar);
                          }
                        },
                        child: Text(
                          'Byrja',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        color: Colors.green,
                        padding: EdgeInsets.all(50),
                        shape: CircleBorder()),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
