import 'package:flutter/material.dart';
import 'package:tesi_prova/Models/Negozio.dart';
import 'package:tesi_prova/Screens/AddNegozioScreen.dart';
import 'package:tesi_prova/Screens/NegozioScreen.dart';

class HomePageScreen extends StatefulWidget {
  static const String routeName = '/HomePage';

  HomePageScreen({Key key, this.title}) : super(key: key);
  final String title;
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<Negozio> negozio;

  void nuovoNegozio(BuildContext context) async {
    Negozio nuovonegozio =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNegozioScreen();
    }));
    if (nuovonegozio != null)
      setState(() {
        negozio.add(nuovonegozio);
      });
  }

  @override
  void initState() {
    super.initState();
    negozio = [
      Negozio(nome: "Carrefour"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => nuovoNegozio(context),
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: negozio.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  key: UniqueKey(),
                  background: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                    child: Align(
                      alignment: Alignment(-0.9, 00),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    setState(() {
                      negozio.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: DecoratedBox(
                      decoration: BoxDecoration(
                          //color: Colors.blue,
                          border: Border.all(
                        color: Colors.black,
                        width: 2,
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          negozio[index].nome,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute<void>(builder: (context) {
                        return NegozioScreen();
                      }));
                    },
                  ));
            }),
      ),
    );
  }
}
