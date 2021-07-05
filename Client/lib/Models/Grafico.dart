import 'package:flutter/material.dart';
//import 'package:fl_chart/fl_chart.dart' as chart;
import 'package:charts_flutter/flutter.dart' as chart;

class GraficoCartesiano extends StatelessWidget {
  final List<Misura> data;
  GraficoCartesiano({@required this.data});


  @override
  Widget build(BuildContext context) {
    List<chart.Series<Misura, int>> series = [
      chart.Series(
        id: "Misura",
        data: data,
        domainFn:(Misura series, _)=>series.x,
        measureFn:(Misura series, _)=> series.y,
      )
    ];
    return chart.LineChart(series, animate: false,);
  }
}

class Misura {
  final int x;
  final int y;

  Misura(this.x, this.y);
}
