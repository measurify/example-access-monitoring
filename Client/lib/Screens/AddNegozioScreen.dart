import 'package:flutter/material.dart';
import 'package:tesi_prova/Models/Negozio.dart';

class AddNegozioScreen extends StatefulWidget {
  AddNegozioScreen({Key key}) : super(key: key);

  _AddNegozioScreenState createState() => _AddNegozioScreenState();
}

class _AddNegozioScreenState extends State<AddNegozioScreen> {
  final Negozio nuovoNegozio = Negozio();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Nuovo Negozio"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () => Navigator.pop(context, nuovoNegozio),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "NOME"),
                onChanged: (value) => nuovoNegozio.nome = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}