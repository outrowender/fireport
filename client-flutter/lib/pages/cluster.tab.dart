import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireport/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ClusterTab extends StatefulWidget {
  @override
  _ClusterTabState createState() => _ClusterTabState();
}

class _ClusterTabState extends State<ClusterTab> {
  var fdb = Firestore.instance;

  deleteCluster(String uid) {
    fdb.document('clusters/$uid').updateData({
      'a': false,
    });
    showMessage(message: 'Estabelecimento desativado');
  }

  copyToken(String token, String title) {
    Clipboard.setData(
        ClipboardData(text: 'Chave de acesso "$title": \n\nsgKEY$token'));
    showMessage(message: 'Chave copiada para área de transferência!');
  }

  showMessage({String message}) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: DraculaPalette.background,
          ),
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('clusters').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text('Error ${snapshot.error}'),
          );

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Text('Loading...'),
            );

          default:
            return ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    child: ListTile(
                      title: Text(document['n'] ?? 'Nome'),
                      subtitle: Text(document['d'] ?? 'Detalhe'),
                    ),
                  ),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Copiar chave',
                      color: DraculaPalette.cyan,
                      icon: Icons.vpn_key,
                      onTap: () =>
                          copyToken(document.documentID, document['n']),
                    ),
                    IconSlideAction(
                      caption: 'Excluir',
                      color: DraculaPalette.red,
                      icon: Icons.delete,
                      onTap: () => deleteCluster(document.documentID),
                    ),
                  ],
                );
              }).toList(),
            );
        }
      },
    );
  }
}
