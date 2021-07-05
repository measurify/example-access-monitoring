import 'package:tesi_prova/Screens/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:tesi_prova/Utils/Variables.dart';
import 'package:http/http.dart' as http1;
import 'dart:convert' as json1;

createAlertDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Username o Password errati"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}

void login(
    BuildContext context, String usrController, String pswController) async {
  var response = await http1.post(url + "/login",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json1.jsonEncode(<String, String>{
        'username': usrController,
        'password': pswController
      }));
  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    var jsonResponse = json1.jsonDecode(response.body);
    token = jsonResponse['token'];
    //getEntranceMeasurements();
    //print(token);
    Navigator.push(context, MaterialPageRoute<void>(builder: (context) {
      return HomePageScreen(title: 'I miei Negozi');
    }));
  } else {
    createAlertDialog(context);
  }
}
