import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireport/auth/FireAuthRepo.dart';
import 'package:fireport/pages/report.page.dart';
import 'package:fireport/pages/useraddcluster.dialog.dart';
import 'package:fireport/services/util.dart';
import 'package:fireport/styles.dart';
import 'package:fireport/widgets/fireports.appbar.dart';
import 'package:flutter/material.dart';

class ClustersPage extends StatefulWidget {
  @override
  _ClustersPageState createState() => _ClustersPageState();
}

class _ClustersPageState extends State<ClustersPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: DraculaPalette.background,
        ),
      ),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext scontext) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: FireportAppBar('Estabelecimentos'),
      body: Builder(
        builder: (newc) => StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('clusters')
              .where('u',
                  arrayContains: FireAuthRepo.of(context).firebaseUser.uid)
              .where('a', isEqualTo: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    return ListTile(
                      title: Text(document['n'] ?? 'Nome'),
                      subtitle: Text(document['d'] ?? 'Detalhe'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ReportsPage(
                              document.documentID,
                              document['n'],
                            );
                          }),
                        )
                      },
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: DraculaPalette.purple,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: scontext,
            builder: (BuildContext context) {
              // return object of type Dialog
              return UserAddClusterDialog(scontext, (message) {
                _displaySnackBar(context, message);
              });
            },
          );
        },
      ),
    );
  }
}
