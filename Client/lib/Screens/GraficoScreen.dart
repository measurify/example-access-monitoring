import 'package:flutter/material.dart';
import 'package:tesi_prova/Models/Grafico.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as json2;
import 'package:http/http.dart' as http2;
import 'package:tesi_prova/Utils/Variables.dart';

class GraficoScreen extends StatefulWidget {
  GraficoScreen({
    Key key,
  }) : super(key: key);

  @override
  _GraficoScreenState createState() => _GraficoScreenState();
}

class _GraficoScreenState extends State<GraficoScreen> {
  DateTime _selectedDate2 = DateTime.now();
  DateTime dataSelezionata;

  List<Misura> data = [
    new Misura(1, 0),
    new Misura(2, 0),
    new Misura(3, 0),
    new Misura(4, 0),
    new Misura(5, 0),
    new Misura(6, 0),
    new Misura(7, 5),
    new Misura(8, 11),
    new Misura(9, 3),
    new Misura(10, 25),
    new Misura(11, 22),
    new Misura(12, 40),
    new Misura(13, 13),
    new Misura(14, 22),
    new Misura(15, 17),
    new Misura(16, 16),
    new Misura(17, 27),
    new Misura(18, 45),
    new Misura(19, 50),
    new Misura(20, 37),
    new Misura(21, 0),
    new Misura(22, 0),
    new Misura(23, 0),
    new Misura(24, 0),
  ];

  void getEntranceMeasurementsForChart(DateTime startDate) async {
    DateFormat df = DateFormat("yyyy-MM-dd");
    DateTime endDate = startDate.add(Duration(days: 1));
    String startDateFormatted = df.format(startDate);
    String endDateFormatted = df.format(endDate);

    var entranceMeasurements = await http2.get(
      url +
          '/measurements?filter={"feature":"entrance","startDate": {"\$gt": "' +
          startDateFormatted +
          '"},"endDate":{"\$lt": "' +
          endDateFormatted +
          '"}}&limit=1000&page=1',
      headers: <String, String>{'Authorization': token},
    );

    if (entranceMeasurements.statusCode == 200) {
      var entranceMeasuremetsString3 =
          json2.jsonDecode(entranceMeasurements.body);
      print(entranceMeasuremetsString3['totalDocs']);
      List listaEntrate = List<int>.generate(24, (index) => 0);
      print(listaEntrate);
      String preparoOra;
      int ora;
      for (int i = 0; i < entranceMeasuremetsString3['totalDocs']; i++) {
        preparoOra = DateFormat.H().format(
            DateTime.parse(entranceMeasuremetsString3['docs'][i]['startDate']));
        if (preparoOra[0] == '0') preparoOra = preparoOra[1];
        ora = int.parse(preparoOra);
        print(ora);
        listaEntrate[ora]++;
        print(listaEntrate);
      }
      setState(() {
        for (int i = 0; i < listaEntrate.length; i++) {
          data[i] = new Misura(i, listaEntrate[i]);
        }
      });

      print(listaEntrate);
    }
  }

  void getData(context) async {
    dataSelezionata = await showDatePicker(
      context: context,
      initialDate: _selectedDate2,
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
    );
    if (dataSelezionata != null)
      setState(() => _selectedDate2 = dataSelezionata);
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat('yyyy/MM/dd');
    return Scaffold(
      appBar: AppBar(
        title: Text('Grafico'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: 450,
        padding: EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    'Grafico Ingressi ogni ora',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            df.format(_selectedDate2),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => getData(context),
                        icon: Icon(Icons.date_range),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: GraficoCartesiano(data: data),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        child: Text('Calcola'),
                        onPressed: () =>
                            getEntranceMeasurementsForChart(_selectedDate2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
