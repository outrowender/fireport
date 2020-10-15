import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireport/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserTab extends StatefulWidget {
  @override
  _UserTabState createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  var fdb = Firestore.instance;

  deleteUser(String uid) {
    fdb.document('users/$uid').delete();
    showMessage(message: 'Usuário removido');
  }

  changePasswordUser(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    showMessage(message: 'Redefinição de senha enviada por email');
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
      stream: fdb.collection('users').orderBy('n').snapshots(),
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
                      title: Text(document['n']),
                      subtitle: Text(document['e']),
                    ),
                  ),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Trocar senha',
                      color: DraculaPalette.orange,
                      icon: Icons.lock,
                      onTap: () => changePasswordUser(document['e']),
                    ),
                    IconSlideAction(
                      caption: 'Excluir',
                      color: DraculaPalette.red,
                      icon: Icons.delete,
                      onTap: () => deleteUser(document.documentID),
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
