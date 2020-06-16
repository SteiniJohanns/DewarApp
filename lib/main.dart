import 'package:MyProviderApp/models/consts_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: ChangeNotifierProvider<Dewar>(
        create: (context) => Dewar(),
        child: MyHomePage(title: 'Alltaf að bauka'),
      ),
      onGenerateRoute: router.generateRoute,
      initialRoute: HomeViewRoute,
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: myContainer(context));
  }

  Container myContainer(BuildContext context) {
    final myDewar = Provider.of<Dewar>(context,listen: false);
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
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Númer',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 2))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Það verður að vera númer';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      myDewar.number = value;
                    },
                  ),
                  SizedBox(height: 10),
                  Consumer<Dewar>(builder: (_,myDewar,__)=> Text(myDewar.gasType == null? 'tómt':myDewar.gasType),
                  ),
                  DropdownButtonFormField<String>(
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
                    value: myDewar.gasType,
                    onChanged: (value) {
                      print(value);
                      myDewar.gasType = value;
                    },
                    onSaved: (value) {
                      myDewar.gasType = value;
                    },
                  ),
                  SizedBox(height: 10),
                  
                  DropdownButtonFormField<String>(
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
                    value: myDewar.dewarType,
                    onChanged: (value) {
                      myDewar.dewarType = value;
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
                            //print(myDewar.dewarType);
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
