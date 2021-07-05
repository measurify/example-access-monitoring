import 'package:flutter/material.dart';
import 'package:tesi_prova/Models/Utente.dart';
//import 'package:tesi_prova/Screens/HomePageScreen.dart';
import 'package:tesi_prova/Utils/Functions.dart';
//import 'package:tesi_prova/Utils/Variables.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert' as json;

class LoginScreen extends StatefulWidget {
  static const String routeName = '/';
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Utente utente = Utente();
  String returnedValue = "Home";
  TextEditingController usrController = TextEditingController();
  TextEditingController pswController = TextEditingController();

  bool isLoginDisabled = true;
  bool cbState = false;
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
          child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                labelText: 'Username',
                icon: Icon(Icons.account_box),
              ),
              controller: usrController,
            ), 
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                labelText: 'Password',
                icon: Icon(Icons.visibility_off),
              ),
              controller: pswController,
              obscureText: false,
            ),
          ),
         /*  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Remember me'),
            ],
          ),
          Checkbox(
            tristate: false,
            activeColor: Colors.blue,
            checkColor: Colors.white,
            value: cbState,
            onChanged: (v) {
              setState(() => cbState = v);
            },
          ), */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Login'),
                onPressed: isLoginDisabled ? null : _loginPressed,
              ),
            ],
          )
        ],
      )),
    ));
  } //build context

  void _loginPressed() {
    login(
        context, usrController.text.toString(), pswController.text.toString());
    /* Navigator.push(context, MaterialPageRoute<void>(builder: (context) {
      return HomePageScreen(title: 'Controllo acessi');
    })); */
  }

  @override
  void initState() {
    super.initState();
    usrController.addListener(formOnChanged);
    //usrController.addListener(removeSomeChar);
    pswController.addListener(formOnChanged);
  }

  void formOnChanged() {
    setState(() {
      isLoginDisabled =
          (usrController.text.length == 0 || pswController.text.length == 0);
    });
  }

  /* void removeSomeChar() {
    final text = usrController.text
        .toLowerCase()
        .replaceAll("@", "")
        .replaceAll("#", "");

    usrController.value = usrController.value.copyWith(
      text: text,
      selection:
          TextSelection(baseOffset: text.length, extentOffset: text.length),
      composing: TextRange.empty,
    );
  } */

  @override
  void dispose() {
    usrController.dispose();
    pswController.dispose();
    super.dispose();
  }
}
