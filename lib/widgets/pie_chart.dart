import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieOutsideLabelChart(this.seriesList, {this.animate});

  factory PieOutsideLabelChart.withSampleData(data) {
    return new PieOutsideLabelChart(
      _createSampleData(data),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              outsideLabelStyleSpec: charts.TextStyleSpec(fontSize: 14, color: charts.MaterialPalette.black),
              labelPosition: charts.ArcLabelPosition.outside)
        ]));
  }

  static List<charts.Series<Cases, int>> _createSampleData(data) {
    return [
      new charts.Series<Cases, int>(
        id: 'Cases',
        domainFn: (Cases cases, _) => cases.percent,
        measureFn: (Cases cases, _) => cases.percent,
        data: data,
        colorFn:(Cases cases, _) => cases.color,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (Cases row, _) => '${row.name}: %${row.percent}',
      ),
    ];
  }
}

class Cases {
  final String name;
  final int percent;
  final charts.Color color;

  Cases(this.name, this.percent, this.color);
}