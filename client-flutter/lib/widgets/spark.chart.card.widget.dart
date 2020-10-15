import 'package:fireport/pages/charts/spark.chart.widget.dart';
import 'package:flutter/material.dart';

class SparkChartCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String detail;
  final String subDetail;
  final List<ChartData> data;
  final Color color;

  SparkChartCard(
      {this.title,
      this.subtitle,
      this.detail,
      this.subDetail,
      this.data,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline,
                    ),
                    Text(
                      '${data.length} $subtitle',
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ],
                ),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      detail,
                      style: Theme.of(context).textTheme.headline,
                    ),
                    Text(
                      subDetail,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ],
                ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 16),
              child: SparkBar(
                content: data,
                color: color,
              ),
            ),
          )
        ],
      ),
    );
  }
}
