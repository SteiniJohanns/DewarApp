

import 'package:MyProviderApp/main.dart';
import 'package:MyProviderApp/models/consts_routes.dart';
import 'package:MyProviderApp/screens/result.dart';
import 'package:MyProviderApp/screens/timeKeeper.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => MyHomePage());
      break;
    case TimeKeeperViewRoute:
      return MaterialPageRoute(builder: (context) => TimeKeeper(myDewar: settings.arguments));
      break;
    case FillingResultViewRoute:
      return MaterialPageRoute(builder: (context) => FillingResult(myFillingResult: settings.arguments));
      break;
    default:
      return MaterialPageRoute(builder: (context) => MyHomePage());

  }
}