import 'dart:convert';

import 'package:MyProviderApp/models/consts.dart';
import 'package:MyProviderApp/models/dewar.dart';
import 'package:http/http.dart' as http;

void saveToGoogleSheets(Dewar fillingResult) async {
  String result = '';
  try {
    await http
        .get(kSaveToGoogleSheetsUrl + fillingResult.toParams())
        .then((response) {
      result = json.decode(response.body)['status'];
      print(result);
    });
  } catch (e) {
    print('Villan er $e');
  }
}
