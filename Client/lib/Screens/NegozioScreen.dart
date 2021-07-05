import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tesi_prova/Utils/Variables.dart';
import 'package:tesi_prova/Screens/GraficoScreen.dart';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;


class NegozioScreen extends StatefulWidget {
  NegozioScreen({
    Key key,
  }) : super(key: key);
  //NegozioScreen({Key key}) : super(key: key);

  @override
  _NegozioScreenState createState() => _NegozioScreenState();
}

class _NegozioScreenState extends State<NegozioScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _dateNow = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDate2 = DateTime.now();
  DateTime data;
  int peopleinside;
  var number = "---";
  var number2 = "---";

  void getData(context) async {
    data = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
    );
    if (data != null) setState(() => _selectedDate = data);
  }

  void getTime(context) async {
    var fTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (fTime != null) setState(() => _selectedTime = fTime);
  }

  void getMeasurements(DateTime startDate) async {
  DateFormat df = DateFormat("yyyy-MM-dd");
  DateTime endDate = startDate.add(Duration(days: 1));
  String startDateFormatted = df.format(startDate);
  String endDateFormatted = df.format(endDate);
  print(startDate);
  print(endDateFormatted);
  print(startDateFormatted);

   var entranceMeasurements = await http.get(
    url +
        '/measurements?filter={"feature":"entrance","startDate": {"\$gt": "' +
        startDateFormatted +
        '"},"endDate":{"\$lt": "' +
        endDateFormatted +
        '"}}',
    headers: <String, String>{'Authorization': token},
  );

  var exitMeasurements = await http.get(
    url +
        '/measurements?filter={"feature":"exit","startDate": {"\$gt": "' +
        startDateFormatted +
        '"},"endDate":{"\$lt": "' +
        endDateFormatted +
        '"}}',
    headers: <String, String>{'Authorization': token},
  );
  /* print(entranceMeasurements.statusCode);
     print(entranceMeasurements.body); */
  if (entranceMeasurements.statusCode == 200 &&
      exitMeasurements.statusCode == 200) {
    var entranceMeasuremetsString = json.jsonDecode(entranceMeasurements.body);
    var exitMeasuremetsString = json.jsonDecode(exitMeasurements.body);
    print(entranceMeasuremetsString['totalDocs']);
    print(exitMeasuremetsString['totalDocs']);
    int risultato = entranceMeasuremetsString['totalDocs'] -
        exitMeasuremetsString['totalDocs'];
        setState(() => number = risultato.toString());
  }
}

void getMeasurements2(DateTime startDate, String startTime) async {
  DateFormat df = DateFormat("yyyy-MM-dd");
  String startDateFormatted2 = df.format(startDate);

  var entranceMeasurements2 = await http.get(
    url +
        '/measurements?filter={"feature":"entrance","startDate": {"\$gt": "' +
        startDateFormatted2 +
        '"},"endDate":{"\$lt": "' +
        startDateFormatted2 +
        'T' +
        startTime +
        '"}}',
    headers: <String, String>{'Authorization': token},
  );

  var exitMeasurements2 = await http.get(
    url +
        '/measurements?filter={"feature":"exit","startDate": {"\$gt": "' +
        startDateFormatted2 +
        '"},"endDate":{"\$lt": "' +
        startDateFormatted2 +
        'T' +
        startTime +
        '"}}',
    headers: <String, String>{'Authorization': token},
  );

  /* print(entranceMeasurements.statusCode);
     print(entranceMeasurements.body); */
  if (entranceMeasurements2.statusCode == 200 && exitMeasurements2.statusCode == 200) {
    var entranceMeasuremetsString2 = json.jsonDecode(entranceMeasurements2.body);
    var exitMeasuremetsString2 = json.jsonDecode(exitMeasurements2.body);
    print(exitMeasuremetsString2['totalDocs']);
    print(entranceMeasuremetsString2['totalDocs']);
    int risultato2 = entranceMeasuremetsString2['totalDocs'] -
        exitMeasuremetsString2['totalDocs'];
        setState(() => number2 = risultato2.toString());
  }
}

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat('yyyy/MM/dd');
    final DateFormat tf = DateFormat('Hm');

    return Scaffold(
      appBar: AppBar(
        title: Text('Negozio'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute<void>(builder: (context) {
              return GraficoScreen();
            })),
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Persone all'interno in questo momento ",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    df.format(_dateNow),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    tf.format(_dateNow),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    number,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Text('Calcola'),
                    onPressed: () => getMeasurements(_selectedDate2),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Guarda l'affluenza giorni precedenti ",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
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
                        df.format(_selectedDate),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        _selectedTime.toString().substring(10, 15),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => getTime(context),
                    icon: Icon(Icons.schedule),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    number2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Text('Calcola'),
                    onPressed: () => getMeasurements2(_selectedDate, _selectedTime.toString().substring(10, 15)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
