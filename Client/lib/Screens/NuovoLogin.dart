import 'package:flutter/material.dart';
import 'package:tesi_prova/Utils/Functions.dart';

class LoginScreen2 extends StatefulWidget {
  static const String routeName = '/';
  LoginScreen2({Key key}) : super(key: key);

  @override
  _LoginScreen2State createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  final _formKey = GlobalKey<FormState>();

  String username;
  String password;

  bool _obscureText = true;
  bool isLoginDisabled = true;

  void _loginPressed() {
    login(context, username, password);
    /* Navigator.push(context, MaterialPageRoute<void>(builder: (context) {
      return HomePageScreen(title: 'Controllo acessi');
    })); */
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Controllo Accessi',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue, 
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (value) => username = value,
                    validator: (value) {
                      if (value.isEmpty)
                        return "Campo Obbligatorio";
                      else if (value.length < 3) return "Valore non valido";
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(fontSize: 14, color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )),
                      suffixIcon: Icon(Icons.account_box),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (value) => password = value,
                    validator: (value) {
                      if (value.isEmpty)
                        return "Campo Obbligatorio";
                      else if (value.length < 3) return "Valore non valido";
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(fontSize: 14, color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _toggle,
                      ),
                    ),
                    obscureText: _obscureText,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Text('Login'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _loginPressed();
                          }
                        }),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
