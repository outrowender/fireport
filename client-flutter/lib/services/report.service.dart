import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:fireport/models/report.model.dart';

class ReportService {
  final Firestore _db = Firestore.instance;

  Future<dynamic> stringIsToken(String token) async {
    const prefix = 'sgKEY';

    if (!token.contains(prefix)) return false;

    var tokenTratado = token.substring(token.indexOf(prefix) + prefix.length);

    var doc = await _db.document('clusters/$tokenTratado').get();

    if (doc.exists) return tokenTratado;

    return false;
  }

  // addUserToCluster({String cluster, String uid}) async {
  //   var db = _db.document('clusters/$cluster');

  //   var query = await db.get();

  //   var list = query.data['u'] as List<String>;

  //   if (list.length == 0) {
  //     db.updateData({
  //       'u': [uid]
  //     });
  //   } else {
  //     list.add(uid);
  //     db.updateData({'u': list});
  //   }
  // }

  //filtra uma lista de máquinas
  Stream<List<Report>> getReports(String uid, int dias) {
    var ref = _db.collection('clusters/$uid/report').where('d',
        isGreaterThan: DateTime.now().subtract(Duration(days: dias)));

    return ref.snapshots().map((list) =>
        list.documents.map((doc) => Report.fromFirestore(doc)).toList());
  }

  //trata toda a chegada do item no firebase e converte para números
  Stream<ReportItem> getRelatorioCompleto(String uid, int dias) {
    return getReports(uid, dias).map((data) {
      //cria array de dias para tratar o resto
      var list = List<int>.generate(dias, (i) => (dias - 1) - i)
          .map((item) => DateTime.now().subtract(Duration(days: item)))
          .toList()
          .map((date) {
        //retorna um map de lista e datas
        return ReportGroup(
            list: data.where((x) {
              var dateA = x.data.toDate();
              return '${dateA.day}-${dateA.month}-${dateA.year}' ==
                  '${date.day}-${date.month}-${date.year}';
            }).toList(),
            label: date.toString());
      }).toList();

      //soma o resultado de cada lista
      var total = list.map((each) {
        //se a lista for vazia, zero pra todo mundo e só salva a data
        if (each.list.length == 0)
          return ReportItem(
            vendas: 0,
            acumulado: 0,
            hosts: 0,
            label: each.label,
          );
        var acumulado =
            each.list.map((item) => item.acumulado).reduce((a, b) => a + b);
        var vendas =
            each.list.map((item) => item.vendas).reduce((a, b) => a + b);

        //retorna um novo objeto item
        return ReportItem(
          vendas: vendas,
          acumulado: acumulado,
          hosts: each.list.length,
          label: each.label,
        );
      }).toList();

      var vendasSum = data.map((item) => item.vendas).reduce((a, b) => a + b);
      var moneySum = data.map((item) => item.acumulado).reduce((a, b) => a + b);

      //retorna os itens tratados
      return ReportItem(
        vendas: vendasSum,
        acumulado: moneySum,
        hosts: data.length,
        label: 'Total',
        list: total,
      );
    });
  }

  getVendas(List<Report> list) {
    print(list.toString());
  }
}

class ReportGroup {
  List<Report> list;
  String label;

  ReportGroup({this.list, this.label});
}

class ReportItem {
  num vendas;
  num acumulado;
  num hosts;
  String label;

  List<ReportItem> list;

  ReportItem({this.vendas, this.acumulado, this.hosts, this.label, this.list});

  @override
  String toString() {
    return '$label: vendas $vendas, acumulado: $acumulado, hosts: $hosts, filhos: ${list?.length}';
  }
}
