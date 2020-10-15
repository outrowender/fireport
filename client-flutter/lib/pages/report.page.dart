import 'package:fireport/pages/charts/spark.chart.widget.dart';
import 'package:fireport/services/report.service.dart';
import 'package:fireport/styles.dart';
import 'package:fireport/widgets/spark.chart.card.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportsPage extends StatefulWidget {
  final String uid;
  final String title;

  ReportsPage(this.uid, this.title);

  @override
  _ReportsPageState createState() => _ReportsPageState(this.uid, this.title);
}

class _ReportsPageState extends State<ReportsPage> {
  final String uid;
  final String title;
  final brFormatter = new NumberFormat("#,##0.00", "pt_BR");

  _ReportsPageState(this.uid, this.title);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: (ReportService()).getRelatorioCompleto(uid, 15),
      builder: (BuildContext c, AsyncSnapshot<ReportItem> s) {
        if (s.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          num totalVendas = s.data?.vendas;
          num totalFundos = s.data?.acumulado;
          List<ChartData> vendas = s.data != null
              ? s.data.list
                  .map((item) => ChartData(item.label, item.vendas))
                  .toList()
              : [ChartData('0', 0)];

          List<ChartData> fundos = s.data != null
              ? s.data.list
                  .map((item) => ChartData(item.label, item.acumulado))
                  .toList()
              : [ChartData('0', 0)];

          return Container(
            color: DraculaPalette.background,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Text(this.title),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SparkChartCard(
                        title: 'Vendas',
                        subtitle: 'dias',
                        detail: totalVendas.toString(),
                        subDetail: '${vendas.last?.value} hoje',
                        data: vendas,
                        color: DraculaPalette.orange,
                      ),
                      SparkChartCard(
                        title: 'Fundos',
                        subtitle: 'dias',
                        detail: 'R\$${brFormatter.format(totalFundos)}',
                        subDetail:
                            'R\$${brFormatter.format(fundos.last?.value)} hoje',
                        data: fundos,
                        color: DraculaPalette.purple,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
