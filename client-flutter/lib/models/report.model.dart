import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String id;
  String mac;
  Timestamp data;
  num vendas;
  num acumulado;

  Report({
    this.id,
    this.mac,
    this.data,
    this.vendas,
    this.acumulado,
  });

  factory Report.fromFirestore(DocumentSnapshot doc) {
    return Report(
      id: doc.documentID,
      mac: doc?.data['m'] ?? '',
      data: (doc?.data['d'] as Timestamp) ?? null,
      vendas: doc?.data['c'] ?? 0,
      acumulado: doc?.data['t'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Máquina $mac dia ${data.toDate().day}, fechou $vendas vendas e faturou R\$$acumulado.';
  }
}
