/// Spark Bar Example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Example of a Spark Bar by hiding both axis, reducing the chart margins.
class SparkBar extends StatelessWidget {
  final List<ChartData> content;
  final Color color;

  SparkBar({this.content, this.color});

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      //data
      _convertData(content, color),
      animate: true,

      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.NoneRenderSpec(),
      ),
      domainAxis: new charts.OrdinalAxisSpec(
        showAxisLine: true,
        renderSpec: new charts.NoneRenderSpec(),
      ),
      layoutConfig: new charts.LayoutConfig(
        leftMarginSpec: new charts.MarginSpec.fixedPixel(0),
        topMarginSpec: new charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: new charts.MarginSpec.fixedPixel(0),
        bottomMarginSpec: new charts.MarginSpec.fixedPixel(0),
      ),
    );
  }

  /// Create series list with single series
  static List<charts.Series<ChartData, String>> _convertData(
      List<ChartData> list, Color color) {
    return [
      new charts.Series<ChartData, String>(
        id: 'Global Revenue',
        domainFn: (ChartData sales, _) => sales.label,
        measureFn: (ChartData sales, _) => sales.value ?? 0,
        data: list,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(color),
      ),
    ];
  }
}

class ChartData {
  final String label;
  final num value;

  ChartData(this.label, this.value);

  @override
  String toString() {
    return 'label: $label, value: $value';
  }
}
