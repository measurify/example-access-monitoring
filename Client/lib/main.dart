import 'package:flutter/material.dart';
//import 'package:tesi_prova/Screens/LoginScreen.dart';
//import 'package:tesi_prova/Screens/NegozioScreen.dart';
import 'package:tesi_prova/Screens/NuovoLogin.dart';

//import 'package:tesi_prova/Screens/HomePageScreen.dart';

//import 'package:tesi_prova/Utils/Router.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      //home:LoginScreen(title: 'Controllo acessi'),
      //home: HomePageScreen(title: 'I miei negozi'),
      home: LoginScreen2(),
    );
  }
}
