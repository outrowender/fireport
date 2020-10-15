import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireport/auth/FireAuthRepo.dart';
import 'package:fireport/services/report.service.dart';
import 'package:fireport/services/util.dart';
import 'package:fireport/widgets/form.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserAddClusterDialog extends StatelessWidget {
  BuildContext bc;
  Function callback;
  UserAddClusterDialog(this.bc, this.callback);

  final tokencontroller = TextEditingController();

  _addToken(String token) async {
    var doc = Firestore.instance.document('clusters/$token');

    var res = await doc.get();

    var listUsers = [];

    //se a lista não estiver vazia, atribui o valor vindo do banco
    if (res.data['u'] != null) listUsers = List<String>.from(res.data['u']);

    var myId = FireAuthRepo.of(this.bc).firebaseUser.uid;

    //se a lista ja contem meu nome, retorna
    if (listUsers.contains(myId)) return;

    //adicioan
    listUsers.add(myId);

    //salva
    doc.updateData({'u': listUsers});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      title: Text('Entrar com token'),
      content: Row(
        children: <Widget>[
          Expanded(
            child: MaterialFormWidgets.textField(
              label: 'Token',
              inputType: TextInputType.emailAddress,
              controller: tokencontroller,
              isPassword: false,
              callback: null,
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () async {
            var istoken =
                await (ReportService()).stringIsToken(tokencontroller.text);

            if (istoken != false) {
              await _addToken(istoken);
              callback('Usuário adicionado!');
            } else {
              callback('Token inválido!');
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
